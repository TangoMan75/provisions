"""
Rename log to current date
"""

import sublime_plugin
import time
import re


class RenameLogCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        # Get the region
        region = self.view.line(0)
        # Get current line as string
        text = self.view.substr(region)

        pattern = r'^(\d{4}-\d{2}-\d{2})(.*)'
        match = re.match(pattern, text)

        if match:
            # Get today's date in YYYY-MM-DD format
            today = time.strftime('%Y-%m-%d')
            text = re.sub(pattern, f"{today}\\2", text)
            new_name = text.strip()

            ##################################################
            # change document title
            ##################################################

            # Replace the region with transformed text
            self.view.replace(edit, region, text)

            # rename file tab
            self.view.set_name(new_name)
