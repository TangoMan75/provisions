"""
Rename log to current date
"""

import sublime
import sublime_plugin
import time
import re
import os


class RenameLogCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        region = self.view.line(0)
        # Get current line as string
        text = self.view.substr(region)

        pattern = r'^(\d{4}-\d{2}-\d{2})(.*)'
        match = re.match(pattern, text)

        if match:
            today = time.strftime('%Y-%m-%d')
            new_text = re.sub(pattern, f"{today}\\2", text)
            new_name = new_text.strip()

            current_file = self.view.file_name()

            if current_file:
                directory = os.path.dirname(current_file)
                _, extension = os.path.splitext(current_file)
                new_file_path = os.path.join(directory, new_name + extension)
                counter = 1
                while os.path.exists(new_file_path):
                    new_file_path = os.path.join(directory, new_name + f"_{counter}" + extension)
                    counter += 1

                # Create new content without modifying the buffer
                old_content = self.view.substr(sublime.Region(0, self.view.size()))
                new_content = old_content.replace(text, new_text, 1)

                # write to new file
                with open(new_file_path, 'w', encoding='utf-8') as f:
                    f.write(new_content)

                # open the new file
                self.view.window().open_file(new_file_path)

                # scratch and close current file
                self.view.set_scratch(True)
