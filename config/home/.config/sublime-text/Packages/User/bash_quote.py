"""
Return a bash-safe double-quoted string that:
  - preserves variable expansion (does NOT escape $),
  - escapes characters that would break double quotes
  - renders control characters as escapes
  - appends a literal new line inside the quotes
  - Uses single quotes when string does not contain variables
"""

import sublime_plugin

class BashQuoteCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        sels = self.view.sel();
        # get all selected text
        for sel in sels:
            if not sel.empty():
                # Get the selected text
                string = self.bash_quote(self.view.substr(sel))

                # Replace the selection with transformed text
                self.view.replace(edit, sel, string)

    def bash_quote(self, s: str) -> str:
        if '$' in s:
            quote_type = '"'
        else:
            quote_type = "'"
        escaped = ''.join(self._escape_char(c, quote_type) for c in s) + '\\n'
        return f'__echo_info {quote_type}{escaped}{quote_type}'

    def _escape_char(self, ch: str, quote_type: str) -> str:
        if quote_type == '"':
            if ch == '"':
                return '\\"'
            if ch == '\\':
                return '\\\\'
            if ch == '`':
                return '\\`'
        elif quote_type == "'":
            if ch == "'":
                return "'\\''"
        if ch == '\n':
            return '\\n'
        if ch == '\t':
            return '\\t'
        if ch == '\r':
            return '\\r'
        # Escape other control chars < 0x20
        o = ord(ch)
        if o < 32:
            return f'\\x{o:02x}'
        return ch
