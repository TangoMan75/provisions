"""
This plugin is compatible with both linux and windows

 - Open Terminal Here
 - Open Command Promt/Git Bash Here

"""

import os
import sys
import sublime_plugin

class TerminalCommand(sublime_plugin.TextCommand):
	def run(self, edit):
		file_name = self.view.file_name()

		if os.name == 'posix' and sys.platform == 'linux':
			current_directory = os.path.dirname(file_name)
			command = 'gnome-terminal --working-directory=' + format(current_directory)

		elif os.name == 'nt':
			path = file_name.split("\\")
			path.pop()
			current_directory = "\\".join(path)
			git_path = "\"C:\\Program Files\\Git\\git-bash.exe\""

			if os.path.isfile(git_path):
				command = git_path + ' --cd=' + current_directory

			else:
				command = 'cd ' + current_directory + ' & ' + current_driver + ' & start cmd'

		else:
			raise NotImplementedError

		os.system(command)
