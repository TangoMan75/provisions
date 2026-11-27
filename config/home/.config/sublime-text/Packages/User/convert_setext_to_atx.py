"""
Sublime Text plugin to convert Markdown setext-style headings to ATX-style headings.

Converts:
    Title           (setext H1)
    =====          → # Title

    Title           (setext H2)
    ----           → ## Title

Usage: Select text and run "Convert Setext To Atx" command, or run on entire file.
"""

import sublime
import sublime_plugin
import re
from pathlib import Path
from typing import Optional


class SetextConverter:
    """Handler to convert setext headings to ATX style."""

    def convert_setext_to_atx(self, text):
        """Convert setext-style headings (underlines) to ATX-style headings (hash prefixes)."""
        def replace_heading(match):
            title = match.group('title').strip()
            if match.group('underline').startswith('='):
                return f"# {title}\n"
            return f"## {title}\n"

        front_matter_pattern = re.compile(r'^---\s*$', re.MULTILINE)
        front_matter_matches = list(front_matter_pattern.finditer(text))

        front_matter = ""
        content_to_process = text

        if len(front_matter_matches) >= 2:
            first_match = front_matter_matches[0]
            second_match = front_matter_matches[1]
            if first_match.start() == 0:
                front_matter_start = first_match.start()
                front_matter_end = second_match.end()
                front_matter = text[front_matter_start:front_matter_end]
                content_to_process = text[front_matter_end:]

        pattern = re.compile(
            r'^(?P<title>\S[^\n]*)\n(?<!\n\n)(?P<underline>[=-]){3,}[^\S\n]*(?:\n|$)',
            re.MULTILINE
        )
        converted = pattern.sub(lambda m: replace_heading(m), content_to_process)

        if front_matter:
            converted = front_matter + converted

        if converted and not converted.endswith('\n'):
            converted = converted + '\n'

        return converted


class ConvertSetextToAtxCommand(sublime_plugin.TextCommand):
    """Sublime Text command to convert setext headings to ATX headings."""
    def run(self, edit):
        view = self.view

        regions = [r for r in view.sel() if not r.empty()]
        if not regions:
            regions = [sublime.Region(0, view.size())]

        converter = SetextConverter()

        for region in regions:
            original = view.substr(region)
            converted = converter.convert_setext_to_atx(original)
            view.replace(edit, region, converted)
