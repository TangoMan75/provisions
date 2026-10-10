"""
Open the file path under the cursor (or in the current selection).

Resolves relative paths against the current file then the project folders,
and supports an optional trailing ":line:col" position.
"""

import os
import re
import sublime
import sublime_plugin

CANDIDATE_RE = re.compile(r"[\w@%+\-~./\\:]+")


class OpenPathCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        target = self._get_target()
        if not target:
            sublime.status_message("Open Path: no file path found")
            return

        path, line, col = self._parse(target)
        resolved = self._resolve(path)
        if not resolved:
            sublime.status_message("Open Path: not found: {}".format(path))
            return

        window = self.view.window()
        if not window:
            return

        if os.path.isdir(resolved):
            window.run_command("open_dir", {"dir": resolved})
            return

        encoded = resolved
        if line:
            encoded += ":{}".format(line)
            if col:
                encoded += ":{}".format(col)

        window.open_file(encoded, sublime.ENCODED_POSITION)

    def _get_target(self):
        for region in self.view.sel():
            if not region.empty():
                return self.view.substr(region).strip()

        sel = self.view.sel()
        if not sel:
            return ""

        point = sel[0].b
        line_region = self.view.line(point)
        text = self.view.substr(line_region)
        col = point - line_region.begin()

        candidates = [
            (match.start(), match.end(), match.group())
            for match in CANDIDATE_RE.finditer(text)
            if self._looks_like_path(match.group())
        ]
        if not candidates:
            return ""

        for start, end, token in candidates:
            if start <= col <= end:
                return token

        return min(
            candidates, key=lambda c: min(abs(c[0] - col), abs(c[1] - col))
        )[2]

    def _looks_like_path(self, token):
        if not token or token in (".", "..", "~"):
            return False
        if token.startswith(("~", "/", "./", "../")):
            return True
        if re.match(r"[A-Za-z]:[\\/]", token):
            return True
        if "/" in token or "\\" in token:
            return True
        return bool(re.search(r"\.[A-Za-z0-9]{1,8}$", token))

    def _parse(self, text):
        line = None
        col = None

        match = re.search(r":(\d+):(\d+)$", text)
        if match:
            line = int(match.group(1))
            col = int(match.group(2))
            text = text[: match.start()]
        else:
            match = re.search(r":(\d+)$", text)
            if match:
                line = int(match.group(1))
                text = text[: match.start()]

        return text, line, col

    def _resolve(self, path):
        path = os.path.expanduser(path)
        if not path:
            return ""

        candidates = []
        if os.path.isabs(path):
            candidates.append(path)
        else:
            file_name = self.view.file_name()
            if file_name:
                candidates.append(
                    os.path.join(os.path.dirname(file_name), path)
                )
            window = self.view.window()
            if window:
                for folder in window.folders():
                    candidates.append(os.path.join(folder, path))

        for candidate in candidates:
            candidate = os.path.normpath(candidate)
            if os.path.exists(candidate):
                return candidate

        return ""
