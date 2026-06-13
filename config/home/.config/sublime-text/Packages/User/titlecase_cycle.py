"""
Cycle through: Capitalize, Title Case, strip accents, sanitizz, UpperCamelCase, and lowerCamelCase
"""

from unicodedata import normalize, category
import re
import sublime_plugin

class TitlecaseCycleCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        sels = self.view.sel();
        # get all selected text
        for sel in sels:
            if not sel.empty():
                # Get the selected text
                string = self.view.substr(sel)

                if self.isTrain(string):
                    string = self.humanize(string);

                elif self.isLowerSnake(string):
                    string = self.humanize(string);

                elif self.isLowerCamel(string):
                    string = self.humanize(string)

                if self.isCapitalized(string):
                    string = string.title();

                elif self.isTitle(string):

                    if self.hasAccents(string):
                        string = self.removeAccents(string)

                    elif self.isDirty(string):
                        string = self.sanitize(string)

                    else:
                        string = self.camelCase(string, True)

                elif self.isUpperCamel(string):
                    string = self.camelCase(string, False)

                else:
                    string = string.capitalize()

                # Replace the selection with transformed text
                self.view.replace(edit, sel, string)

    def isLower(self, string):
        return string == string.lower()

    def isUpper(self, string):
        return string == string.upper()

    def isCapitalized(self, string):
        return string == string.capitalize()

    def isTitle(self, string):
        if ' ' not in string:
            return False

        return string == string.title()

    def isUpperCamel(self, string):
        if ' ' in string or '-' in string or '_' in string or string == string.lower() or string == string.upper():
            return False

        return string == self.camelCase(string, True)

    def isLowerCamel(self, string):
        if ' ' in string or '-' in string or '_' in string or string == string.lower() or string == string.upper():
            return False

        return string == self.camelCase(string, False)

    def isDirty(self, string):
        return string != self.sanitize(string)

    def hasAccents(self, string):
        return string != self.removeAccents(string)

    def isTrain(self, string):
        if ' ' in string or '_' in string:
            return False

        return '-' in string and string == self.trainCase(string)

    def isUpperSnake(self, string):
        if ' ' in string or '-' in string:
            return False

        return string == self.snakeCase(string, True)

    def isLowerSnake(self, string):
        if ' ' in string or '-' in string:
            return False

        return string == self.snakeCase(string, False)

    def humanize(self, string):
        if self.isUpperCamel(string) or self.isLowerCamel(string):
            # humanize
            string = re.sub('[A-Z]', lambda match: ' '+str(match.group(0)), string)

            # remove first space from string if any
            string = re.sub('^\s', '', string)

        # Replace underscores and dashes
        string = re.sub('[_-]+', ' ', string)

        string = self.sanitize(string)

        return string

    def camelCase(self, string, upper = False):
        string = self.removeAccents(string)

        if self.isUpperSnake(string):
            string = string.lower()

        string = self.sanitize(string)
        string = re.sub('_', ' ', string)

        if ' ' in string:
            string = string.title()
            # Remove all spaces
            string = re.sub(' ', '', string)

        if False == upper:
            string = string[:1].lower() + string[1:]

        if True == upper:
            string = string[:1].upper() + string[1:]

        return string

    def trainCase(self, string):
        string = self.sanitize(string)

        # Replace spaces or underscores with dashes
        string = re.sub('[\s_]', '-', string)

        # convert string to lowercase
        string = string.lower()

        return string

    def snakeCase(self, string, upper = False):
        string = self.removeAccents(string)

        string = self.sanitize(string)

        # Replace spaces or dashed with underscores
        string = re.sub('[\s-]', '_', string)

        if True == upper:
            string = string.upper()
        else:
            string = string.lower()

        return string

    def removeAccents(self, string):
        # Remove accents from string (unicodedata method)
        return ''.join(char for char in normalize('NFD', string) if category(char) != 'Mn')

    def sanitize(self, string):
        # Replace all non word characters (except underscores and dashes) and removes extra spaces
        return re.sub('([^\w_-]|\s)+', ' ', string).strip()

