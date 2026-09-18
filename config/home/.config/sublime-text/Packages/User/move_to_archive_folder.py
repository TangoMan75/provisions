import sublime
import sublime_plugin
import os
import shutil

class MoveToArchiveCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        view = self.view
        file_name = view.file_name()

        if not file_name:
            sublime.error_message("File has no path. Save it first.")
            return

        directory = os.path.dirname(file_name)
        archive_dir = os.path.join(directory, "archive")

        if not os.path.exists(archive_dir):
            os.makedirs(archive_dir)

        file_name_only = os.path.basename(file_name)
        dest_path = os.path.join(archive_dir, file_name_only)

        counter = 1
        base, ext = os.path.splitext(file_name_only)
        while os.path.exists(dest_path):
            dest_path = os.path.join(archive_dir, f"{base}_{counter}{ext}")
            counter += 1

        shutil.move(file_name, dest_path)

        window = sublime.active_window()
        window.run_command("close")
        
        sublime.status_message(f"Moved to archive: {os.path.basename(dest_path)}")