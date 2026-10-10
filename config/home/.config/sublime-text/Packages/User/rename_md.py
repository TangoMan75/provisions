"""
rename_md: Rename markdown file to current date
"""

import sublime
import sublime_plugin
import time
import re
import os


class RenameMdCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        current_file = self.view.file_name()
        if not current_file:
            return

        first_line = self.view.substr(self.view.line(0))

        # Match pattern: optional ATX heading prefix (#), date, and title
        # e.g. "2024-01-15 My Log" or "# 2024-01-15 My Log"
        pattern = r'^(#+\s)?(\d{4}-\d{2}-\d{2})(.*)'
        match = re.match(pattern, first_line)
        if not match:
            return

        today = time.strftime('%Y-%m-%d')
        new_first_line = re.sub(pattern, rf"\g<1>{today}\g<3>", first_line)
        new_name = re.sub(r'^#+\s+', '', new_first_line).strip()

        directory = os.path.dirname(current_file)
        _, extension = os.path.splitext(current_file)
        new_file_path = os.path.join(directory, new_name + extension)

        # Avoid overwriting existing files by appending _1, _2, etc.
        counter = 1
        while os.path.exists(new_file_path):
            new_file_path = os.path.join(directory, f"{new_name}_{counter}{extension}")
            counter += 1

        # Replace the date prefix in the h1 header
        updated_content = re.sub(pattern, rf"\g<1>{today}\g<3>", self.view.substr(sublime.Region(0, self.view.size())), count=1)
        self.view.replace(edit, sublime.Region(0, self.view.size()), updated_content)
        os.rename(current_file, new_file_path)
        self.view.retarget(new_file_path)
        self.view.run_command("save")
