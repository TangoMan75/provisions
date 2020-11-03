"""
Remove accents from string
"""

import sublime_plugin
import re

class CaseToCamelCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        sels = self.view.sel();
        # get all selected text
        for sel in sels:
            if not sel.empty():
                # Get the selected text
                string = self.view.substr(sel)

                # Remove spaces
                string = re.sub(' ', '', string)

                # Replace underscores
                string = re.sub('_', ' ', string)

                # Replace tacks
                string = re.sub('-', '_', string)

                # Replace the selection with transformed text
                self.view.replace(edit, sel, string)
