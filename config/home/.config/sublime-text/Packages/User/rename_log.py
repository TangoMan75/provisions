"""
rename_log: Rename log to current date
"""

import sublime
import sublime_plugin
import time
import re
import os


class RenameLogCommand(sublime_plugin.TextCommand):
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

        old_content = self.view.substr(sublime.Region(0, self.view.size()))

        # Split at the first horizontal rule: a line of 3+ dashes
        hr_match = re.search(r'^\s*-{3,}\s*$', old_content, re.MULTILINE)

        if hr_match:
            kept = old_content[:hr_match.end()]
            carryover = old_content[hr_match.start():]

            new_content = new_first_line + '\n' + carryover

            with open(new_file_path, 'w', encoding='utf-8') as f:
                f.write(new_content)

            self.view.replace(edit, sublime.Region(0, self.view.size()), kept)

            with open(current_file, 'w', encoding='utf-8') as f:
                f.write(kept)

            self.view.run_command("save")
            self.view.window().open_file(new_file_path)
        else:
            updated_content = re.sub(pattern, rf"\g<1>{today}\g<3>", old_content, count=1)
            self.view.replace(edit, sublime.Region(0, self.view.size()), updated_content)
            os.rename(current_file, new_file_path)
            self.view.retarget(new_file_path)
            self.view.run_command("save")
