"""
frontmatter: Create or update YAML frontmatter in markdown files.

Managed keys are filled from the file system:
    date_created  - file creation time (birth time when available)
    date_modified - file last modification time
    file_name     - file base name
    tags          - parent folder name, merged with existing tags (normalised to lower-train-case)

Existing frontmatter keys are preserved. Bound to ctrl+k ctrl+f.
"""

import os
import re
from datetime import datetime

import sublime
import sublime_plugin

MANAGED_KEYS = ("date_created", "date_modified", "file_name", "tags")
FENCE = "---"
KEY_LINE_RE = re.compile(r"^([A-Za-z0-9_.-]+):(.*)$")
BLOCK_ITEM_RE = re.compile(r"^\s+-\s*(.*)$")
DATE_PREFIX_RE = re.compile(r"^(\d{4}-\d{2}-\d{2})")


def _timestamp(seconds):
    """File system seconds -> ISO 8601 with local offset."""
    return datetime.fromtimestamp(seconds).astimezone().isoformat(timespec="seconds")


def _format_tag(tag):
    """Convert tag to lower-train-case: lowercase, spaces/underscores to hyphens."""
    return re.sub(r"[\s_]+", "-", str(tag).lower()).strip("-")


def _quote(value):
    return "'" + str(value).replace("'", "''") + "'"


def _unquote(value):
    value = value.strip()
    if len(value) > 1 and value[0] == value[-1] and value[0] in "'\"":
        inner = value[1:-1]
        if value[0] == "'":
            inner = inner.replace("''", "'")
        return inner
    return value


def _split_inline(value):
    """Split a comma separated list body, honouring quoted items."""
    parts = []
    buf = []
    quote = None
    index = 0
    while index < len(value):
        char = value[index]
        if quote:
            if char == quote:
                if quote == "'" and index + 1 < len(value) and value[index + 1] == "'":
                    buf.append("''")
                    index += 2
                    continue
                quote = None
            buf.append(char)
        elif char in "'\"":
            quote = char
            buf.append(char)
        elif char == ",":
            parts.append("".join(buf))
            buf = []
        else:
            buf.append(char)
        index += 1
    parts.append("".join(buf))
    return [part.strip() for part in parts if part.strip()]


def _parse_list(value):
    value = value.strip()
    if value.startswith("["):
        value = value[1:]
    if value.endswith("]"):
        value = value[:-1]
    if not value.strip():
        return []
    return [_unquote(item) for item in _split_inline(value)]


def _render(key, value):
    if isinstance(value, (list, tuple)):
        if value:
            lines = [key + ":"]
            for item in value:
                lines.append("  - " + _quote(item))
            return lines
        return [key + ": []"]
    return [key + ": " + _quote(value)]


def _split_entries(body_lines):
    """Group front matter lines into ordered [key, lines] entries."""
    entries = []
    for line in body_lines:
        match = KEY_LINE_RE.match(line)
        if match:
            entries.append([match.group(1), [line]])
        elif entries:
            entries[-1][1].append(line)
        else:
            entries.append([None, [line]])
    return entries


def _inline_value(entry_lines):
    match = KEY_LINE_RE.match(entry_lines[0])
    return match.group(2).strip() if match else ""


def _block_items(entry_lines):
    items = []
    for line in entry_lines[1:]:
        match = BLOCK_ITEM_RE.match(line)
        if match and match.group(1).strip():
            items.append(_unquote(match.group(1)))
    return items


class UpdateFrontmatterCommand(sublime_plugin.TextCommand):
    """Create or update front matter from file system metadata."""

    def run(self, edit):
        view = self.view
        path = view.file_name()

        if not path:
            sublime.status_message("Frontmatter: save the file first")
            return

        if not (view.match_selector(0, "text.html.markdown")
                or path.endswith((".md", ".markdown"))):
            sublime.status_message("Frontmatter: markdown files only")
            return

        try:
            stat = os.stat(path)
        except OSError:
            sublime.status_message("Frontmatter: cannot read file system data")
            return

        created = _timestamp(getattr(stat, "st_birthtime", stat.st_ctime))
        modified = _timestamp(stat.st_mtime)
        name = os.path.basename(path)
        folder = os.path.basename(os.path.dirname(os.path.abspath(path)))

        text = view.substr(sublime.Region(0, view.size()))
        bom = "\ufeff" if text.startswith("\ufeff") else ""
        body = text[len(bom):]
        lines = body.split("\n")

        close = None
        if lines and lines[0].strip() == FENCE:
            for index in range(1, len(lines)):
                if lines[index].strip() == FENCE:
                    close = index
                    break
            if close is None:
                sublime.status_message("Frontmatter: unterminated '---' block")
                return

        if close is None:
            values = self._build_values({}, created, modified, name, folder)
            block = [FENCE]
            for key in MANAGED_KEYS:
                block.extend(_render(key, values[key]))
            block.append(FENCE)
            new_text = "\n".join(block) + "\n"
            if body and not body.startswith("\n"):
                new_text += "\n"
            view.insert(edit, len(bom), new_text)
            sublime.status_message("Frontmatter created")
            return

        entries = _split_entries(lines[1:close])
        existing = {}
        for key, entry_lines in entries:
            if key in MANAGED_KEYS and key not in existing:
                existing[key] = entry_lines

        values = self._build_values(existing, created, modified, name, folder)

        rendered = []
        seen = set()
        for key, entry_lines in entries:
            if key in MANAGED_KEYS:
                if key in seen:
                    continue
                seen.add(key)
                rendered.extend(_render(key, values[key]))
            else:
                rendered.extend(entry_lines)

        for key in MANAGED_KEYS:
            if key not in seen:
                rendered.extend(_render(key, values[key]))

        block = [FENCE] + rendered + [FENCE + "\n"]
        end = min(sum(len(line) + 1 for line in lines[:close + 1]), len(body))
        view.replace(edit, sublime.Region(len(bom), len(bom) + end),
                     "\n".join(block))
        sublime.status_message("Frontmatter updated")

    @staticmethod
    def _build_values(existing, created, modified, name, folder):
        values = {}

        entry = existing.get("date_created")
        raw = _inline_value(entry) if entry else ""
        date_match = DATE_PREFIX_RE.match(name)
        if date_match:
            created_dt = datetime.fromisoformat(created)
            tz = created_dt.tzinfo
            dt = datetime.strptime(date_match.group(1), "%Y-%m-%d").replace(tzinfo=tz)
            values["date_created"] = dt.isoformat(timespec="seconds")
        elif raw:
            values["date_created"] = _unquote(raw)
        else:
            values["date_created"] = created

        values["date_modified"] = modified
        values["file_name"] = name

        tags = []
        entry = existing.get("tags")
        if entry:
            raw = _inline_value(entry)
            if raw:
                tags = _parse_list(raw) if raw.startswith("[") else [_unquote(raw)]
            else:
                tags = _block_items(entry)
        if folder:
            tags.append(folder)

        deduped = []
        for tag in tags:
            tag = _format_tag(tag)
            if tag and tag not in deduped:
                deduped.append(tag)
        values["tags"] = deduped

        return values
