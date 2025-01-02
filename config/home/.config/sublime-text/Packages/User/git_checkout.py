"""
This plugin is meant for linux
git checkout this file
"""

import os
import sublime_plugin

class GitCheckoutCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        file_name         = self.view.file_name()
        current_directory = os.path.dirname(file_name)
        command           = 'gnome-terminal --working-directory='+current_directory+' -x sh -c "git checkout '+file_name+'"'

        print(command)
        os.system(command)
