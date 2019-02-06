from ranger.api.commands import Command

import os
from ranger.core.loader import CommandLoader

# marked_items are the selected items, it can be empty if no selection
# get_selection() always returns something, if no marked_items, returns the current item
# .files is the list of all files in the current cwd

# List of flags for fm.run. See ranger/core/runner.py

# s: silent mode. output will be discarded.
# f: fork the process.
# p: redirect output to the pager
# c: run only the current file (not handled here)
# w: wait for enter-press afterwards
# r: run application with root privilege (requires sudo)
# t: run application in a new terminal window

class compress(Command):
    def execute(self):
        """ Compress files to current directory """
        import subprocess

        cwd = self.fm.thisdir
        marked_files = cwd.get_selection() if cwd.marked_items else cwd.files

        def refresh(_):
            cwd = self.fm.get_directory(original_path)
            cwd.load_content()

        original_path = cwd.path
        parts = self.line.split()
        au_flags = parts[1:]

        cmd = ['apack'] + au_flags + [os.path.relpath(f.path, cwd.path) for f in marked_files]
        files = ' '.join([os.path.relpath(f.path, cwd.path) for f in marked_files])
        self.fm.notify(files)
        cmd2 = 'tar -zcv {} | gpg --encrypt -r 52D5867B > {}.gpg'.format(files, au_flags[0])

        # descr = "compressing files in: " + os.path.basename(parts[1])
        # obj = CommandLoader(args=cmd, descr=descr)
        # obj.signal_bind('after', refresh)
        # self.fm.loader.add(obj)

        # self.fm.run(cmd, flags='p')

        # self.fm.execute_command(cmd2, stdout=subprocess.PIPE)
        self.fm.run(cmd2, flags='p')

    def tab(self, tabnum):
        """ Complete with current folder name """

        extensions = [
            '.tgz',
            '.7z',
            '.zip',
        ]
        if self.arg(1).endswith('.tgz'):
            extensions = extensions[1:]

        return ['compress ' + os.path.basename(self.fm.thisdir.path) + ext for ext in extensions]
