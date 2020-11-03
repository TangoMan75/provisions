"""
This plugin is meant for linux
Execute this
"""

import os
import sublime_plugin

class ExecuteCommand(sublime_plugin.TextCommand):
	def run(self, edit):
		file_name         = self.view.file_name()
		current_directory = os.path.dirname(file_name)
		command           = 'chmod +x '+file_name+' && gnome-terminal --working-directory='+current_directory+' -x sh -c "'+file_name+'; bash"'
		os.system(command)
