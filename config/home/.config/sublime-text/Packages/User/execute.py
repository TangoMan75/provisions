"""
This plugin is meant for linux
Execute this
"""

import os
import sublime_plugin

class ExecuteCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        file_path         = self.view.file_name()
        current_directory = os.path.dirname(file_path)
        command           = 'chmod +x {} && gnome-terminal --working-directory={} -- sh -c "{}; echo; echo press ctrl+c to quit...; tail"'.format(file_path, current_directory, file_path)
        # command           = 'chmod +x {} && gnome-terminal --working-directory={} -x sh -c "{}; echo; echo press ctrl+c to quit...; tail"'.format(file_path, current_directory, file_path)
        os.system(command)
