"""
Diff Links Plugin
Makes file paths in diff/patch files clickable.
Resolves paths against the project root defined in $XDG_CURRENT_PROJECT.
"""

import os
import re
import sublime
import sublime_plugin


REGION_KEY = 'diff_file_links'

RE_FROM_FILE = re.compile(r'^--- (?:[abicwi]|ours|theirs)/(\S+?)(?:\s|$)')
RE_TO_FILE   = re.compile(r'^\+\+\+ (?:[abicwi]|ours|theirs)/(\S+?)(?:\s|$)')
RE_HUNK      = re.compile(r'^@@ -(\d+)(?:,(\d+))? \+(\d+)(?:,(\d+))? @@')


def get_project_root():
    return os.environ.get('XDG_CURRENT_PROJECT', '').rstrip(os.sep)


def is_diff_view(view):
    syntax = view.settings().get('syntax', '') or ''
    if 'diff' in syntax.lower():
        return True
    file_name = view.file_name() or ''
    if file_name.endswith(('.diff', '.patch')):
        return True
    if view.size() > 0:
        first_line = view.substr(view.line(0))
        if first_line.startswith('diff --git') or first_line.startswith('--- '):
            return True
    return False


def path_region_for(view, line_region, path):
    path_start = view.substr(line_region).find(path)
    if path_start < 0:
        return None
    a = line_region.a + path_start
    return sublime.Region(a, a + len(path))


def parse_hunk_line_number(line):
    m = RE_HUNK.match(line)
    if not m:
        return None
    old_count = int(m.group(2)) if m.group(2) is not None else 1
    new_start = int(m.group(3))
    return new_start + old_count


class DiffFileLinkListener(sublime_plugin.EventListener):

    def on_load_async(self, view):
        self.update_links(view)

    def on_modified_async(self, view):
        self.update_links(view)

    def on_activated_async(self, view):
        self.update_links(view)

    def update_links(self, view):
        if not is_diff_view(view):
            view.erase_regions(REGION_KEY)
            return

        regions = []
        current_file = None

        for line_region in view.lines(sublime.Region(0, view.size())):
            line = view.substr(line_region)

            m = RE_FROM_FILE.match(line)
            if m:
                r = path_region_for(view, line_region, m.group(1))
                if r is not None:
                    regions.append(r)
                current_file = m.group(1)
                continue

            m = RE_TO_FILE.match(line)
            if m:
                r = path_region_for(view, line_region, m.group(1))
                if r is not None:
                    regions.append(r)
                current_file = m.group(1)
                continue

            if RE_HUNK.match(line) and current_file is not None:
                regions.append(sublime.Region(line_region.a, line_region.b))

        view.add_regions(
            REGION_KEY,
            regions,
            'markup.underline.diff_links',
            '',
            sublime.DRAW_SOLID_UNDERLINE | sublime.PERSISTENT,
        )


class DiffOpenFileCommand(sublime_plugin.TextCommand):

    def run(self, edit, event=None):
        if event is not None:
            pos = self.view.window_to_text((event['x'], event['y']))
        else:
            sel = self.view.sel()
            if not sel:
                return
            pos = sel[0].a

        result = self.get_link_at(pos)
        if result is None:
            sublime.status_message('Diff Links: no file reference at cursor')
            return

        path, line_num = result

        root = get_project_root()
        if not root:
            sublime.status_message('Diff Links: $XDG_CURRENT_PROJECT is not set')
            return

        abs_path = os.path.join(root, path)
        file_url = 'file://' + abs_path
        if line_num is not None:
            file_url += ':' + str(line_num)

        self.view.window().open_file(file_url, sublime.ENCODED_POSITION)

    def get_link_at(self, pos):
        line_region = self.view.line(pos)
        line = self.view.substr(line_region)
        line_num = self.view.rowcol(pos)[0]

        m_from = RE_FROM_FILE.match(line)
        if m_from:
            r = path_region_for(self.view, line_region, m_from.group(1))
            if r is not None and r.contains(pos):
                return m_from.group(1), None

        m_to = RE_TO_FILE.match(line)
        if m_to:
            r = path_region_for(self.view, line_region, m_to.group(1))
            if r is not None and r.contains(pos):
                return m_to.group(1), None

        hunk_line = parse_hunk_line_number(line)
        if hunk_line is not None:
            current_file = self.get_current_file(line_num)
            if current_file is not None:
                return current_file, hunk_line

        return None

    def get_current_file(self, before_line):
        for i in range(before_line, -1, -1):
            line = self.view.substr(self.view.line(self.view.text_point(i, 0)))
            m = RE_TO_FILE.match(line) or RE_FROM_FILE.match(line)
            if m:
                return m.group(1)
        return None
