"""
Insert datetime
"""

import sublime_plugin
import time

"""
date_format_en          = '%Y-%m-%d'       # 2016-01-01
date_format_fr          = '%d/%m/%Y'       # 01/01/2016
datetime_format_long_en = '%Y-%m-%d_%H-%M' # 2016-01-01_00-00
datetime_format_long_fr = '%H:%M %d/%m/%Y' # 00:00 01/01/2016
time_format_long        = '%H:%M:%S'       # 00:00:00
time_format_short       = '%H:%M'          # 00:00
"""

class InsertDatetimeCommand(sublime_plugin.TextCommand):
	def run(self, edit):
		# 00:00 01/01/2016
		datetime_format_long_fr = '%H:%M %d/%m/%Y'
		sels = self.view.sel();
		for sel in sels:
			if sel.empty():
				self.view.insert(edit, sel.a, time.strftime(datetime_format_long_fr))
			else:
				self.view.replace(edit, sel, time.strftime(datetime_format_long_fr))
