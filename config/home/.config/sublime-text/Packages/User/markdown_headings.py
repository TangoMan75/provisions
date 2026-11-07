import sublime
import sublime_plugin
import re

HEADING_RE = re.compile(r"^(#{1,6})(\s+)(.*)$")


class MarkdownShiftHeadingsCommand(sublime_plugin.TextCommand):
    """Increase or decrease heading levels for the selection or whole file."""

    def run(self, edit, direction=1):
        if not self.view.match_selector(0, "text.html.markdown") and \
                self.view.file_name() is not None and \
                not self.view.file_name().endswith((".md", ".markdown")):
            # still attempt, but prefer markdown scope; allow running anyway
            pass

        if self.view.has_non_empty_selection_region():
            regions = [r for r in self.view.sel() if not r.empty()]
        else:
            regions = [sublime.Region(0, self.view.size())]

        for region in regions:
            self._shift_region(edit, region, direction)

    def _shift_region(self, edit, region, direction):
        # Work on full lines spanned by the region
        line_start = self.view.line(region.begin()).begin()
        line_end = self.view.line(region.end()).end()
        region = sublime.Region(line_start, line_end)

        text = self.view.substr(region)
        new_lines = []
        for line in text.split("\n"):
            match = HEADING_RE.match(line)
            if not match:
                new_lines.append(line)
                continue
            hashes, space, rest = match.groups()
            level = len(hashes)
            if direction > 0:
                level = min(level + 1, 6)
            else:
                level = max(level - 1, 1)
            new_lines.append("#" * level + space + rest)
        self.view.replace(edit, region, "\n".join(new_lines))


class MarkdownIncreaseHeadingCommand(MarkdownShiftHeadingsCommand):
    def run(self, edit):
        super().run(edit, direction=1)


class MarkdownDecreaseHeadingCommand(MarkdownShiftHeadingsCommand):
    def run(self, edit):
        super().run(edit, direction=-1)
