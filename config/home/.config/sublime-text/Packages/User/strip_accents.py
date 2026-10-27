"""
Remove accents from string
"""

import sublime_plugin
from unicodedata import normalize, category

class StripAccentsCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        sels = self.view.sel();
        # get all selected text
        for sel in sels:
            if not sel.empty():
                # Get the selected text
                string = self.view.substr(sel)

                # Remove accents from string (unicodedata method)
                string = ''.join(char for char in normalize('NFD', string) if category(char) != 'Mn')

                # Replace the selection with transformed text
                self.view.replace(edit, sel, string)
