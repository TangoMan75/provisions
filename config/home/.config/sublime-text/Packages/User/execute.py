"""
This plugin is meant for linux
Execute this
"""

import os
import subprocess
import sublime_plugin

class ExecuteCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        file_path         = self.view.file_name()
        current_directory = os.path.dirname(file_path)
        command           = f'chmod +x "{file_path}" && xdg-terminal-exec --dir="{current_directory}" -- sh -c "{file_path}; echo; echo press ctrl+d to quit...; tail"'
        print(command)
        subprocess.Popen(
            command,
            shell=True,
            start_new_session=True,
            stdin=subprocess.DEVNULL,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
