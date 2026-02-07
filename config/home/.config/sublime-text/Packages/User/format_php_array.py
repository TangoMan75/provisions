"""
Format PHP array console dump to proer syntax
"""

import sublime_plugin
import sublime
from re import sub

class FormatPhpArrayCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        # https://www.sublimetext.com/docs/3/api_reference.html#sublime.View
        # Get the region
        region = sublime.Region(0, self.view.size())

        # Get the whole text as string
        text = self.view.substr(region)

        # remove "array:1 "
        text = sub('array:\d+\s', '', text)

        # remove "0 => "
        text = sub('\d+\s=>\s', '', text)

        # place comma at the end
        text = sub('\n', ',\n', text)

        # remove extra commas
        text = sub('\[,', '[', text)

        # Trim content
        text = text.strip()

        # replace last comma with semicolon
        text = sub('\],$', '];', text)

        # Replace the region with transformed text
        self.view.replace(edit, region, text)