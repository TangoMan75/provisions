"""
This plugin is meant for linux
Shellcheck this
"""

import os
import subprocess
import sublime_plugin

class ShellcheckCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        file_path         = self.view.file_name()
        current_directory = os.path.dirname(file_path)
        command           = f'xdg-terminal-exec -- sh -c "echo \\"Checking: {file_path}\\"; shellcheck -x {file_path}; echo \\"press ctrl+d to quit...\\"; tail"'
        print(command)
        subprocess.Popen(
            command,
            shell=True,
            start_new_session=True,
            stdin=subprocess.DEVNULL,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
