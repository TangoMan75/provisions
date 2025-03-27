"""
This plugin is meant for linux
Shellcheck this
"""

import os
import sublime_plugin

class ShellcheckCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        file_path         = self.view.file_name()
        current_directory = os.path.dirname(file_path)
        command           = 'gnome-terminal --working-directory={} -- sh -c "shellcheck -x {}; echo; echo press ctrl+c to quit...; tail"'.format(current_directory, file_path)
        os.system(command)
