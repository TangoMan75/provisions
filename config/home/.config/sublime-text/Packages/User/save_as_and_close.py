"""
Save as UTF-8 and close file
"""

import sublime_plugin

class SaveAsAndCloseCommand(sublime_plugin.WindowCommand):
    def run(self):
        self.window.run_command('save', {'encoding': 'UTF-8'})
        self.window.run_command('close')
