import ranger.api
from ranger.api.commands import Command

import os
import subprocess
from functools import partial
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
        cwd = self.fm.thisdir
        parent_dir = os.path.dirname(cwd.path)
        marked_files = cwd.get_selection() if cwd.marked_items else cwd.files

        output = self.arg(1)
        files = ' '.join(['"{}"'.format(os.path.relpath(f.path, cwd.path)) for f in marked_files])
        files_p = ' '.join(['"{}"'.format(os.path.relpath(f.path, parent_dir)) for f in marked_files])

        if output.endswith('.tgz'):
            cmd = f'tar -zc -C {parent_dir} {files_p} > {output}'
        elif output.endswith('.tgz.gpg'):
            cmd = f'tar -zc -C {parent_dir} {files_p} | gpg --encrypt -r 52D5867B > {output}'
        elif output.endswith('.zip') or output.endswith('.7z'):
            cmd = f'apack -f {output} {files}'
        else:
            self.fm.notify(f"Error: unkwnow file extension ({output})!", bad=True)
            return

        if f'{cwd}/{output}' in [f.path for f in cwd.files]:
            self.fm.ui.console.ask(
                f"Overwrite {output}? (y/N)",
                partial(self._question_callback, cmd),
                ('n', 'N', 'y', 'Y'),
            )
        else:
            self._question_callback(cmd, 'Y')

    def _question_callback(self, cmd, answer):
        if answer == 'y' or answer == 'Y':
            # self.fm.run(f'echo "{cmd}"', flags='p')
            self.fm.run(cmd)


    def tab(self, tabnum):
        """ Complete with current folder name """

        extensions = [
            '.tgz',
            '.7z',
            '.tgz.gpg',
            '.zip',
        ]
        if self.arg(1).endswith('.tgz'):
            extensions = extensions[1:]

        return ['compress ' + os.path.basename(self.fm.thisdir.path) + ext for ext in extensions]


class fzf_select(Command):
    """
    :fzf_select

    Find a file using fzf.

    See: https://github.com/junegunn/fzf
    """
    def execute(self):
        command = 'fd --hidden --follow --exclude ".git" --type file --type symlink | fzf +m'
        fzf = self.fm.execute_command(command, universal_newlines=True, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)


class fzf_autojump(Command):
    """
    :fzf_select

    Find a file using fzf.

    See: https://github.com/junegunn/fzf
    """
    def execute(self):
        command = '''
        autojump -s | head -n -7 | sort -nr | awk '{print $2}' | fzf +s --preview "tree -C {} | head -200"
        '''
        fzf = self.fm.execute_command(command, universal_newlines=True, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)


def hook_init(fm):
    def update_autojump(signal):
        subprocess.call(["autojump", "--add", signal.new.path])

    fm.signal_bind('cd', update_autojump)

ranger.api.hook_init = hook_init

class j(Command):
    """:j
    Uses autojump to set the current directory.
    """

    def execute(self):
        directory = subprocess.check_output(["autojump", self.arg(1)])
        directory = directory.decode("utf-8", "ignore")
        directory = directory.rstrip('\n')
        self.fm.execute_console("cd " + directory)
