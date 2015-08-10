import os
from os.path import expanduser

c = get_config()

c.NotebookApp.notebook_dir = os.path.expanduser('~/projects/notebooks')


#------------------------------------------------------------------------------
# NotebookManager configuration
#------------------------------------------------------------------------------

# The directory to use for notebooks.
# c.NotebookManager.notebook_dir = '/home/user'

#------------------------------------------------------------------------------
# FileNotebookManager configuration
#------------------------------------------------------------------------------

# FileNotebookManager will inherit config from: NotebookManager

# The location in which to keep notebook checkpoints
#
# By default, it is notebook-dir/.ipynb_checkpoints
# c.FileNotebookManager.checkpoint_dir = ''

# The directory to use for notebooks.
# c.FileNotebookManager.notebook_dir = '/home/user'

# Automatically create a Python script when saving the notebook.
#
# For easier use of import, %run and %load across notebooks, a <notebook-
# name>.py script will be created next to any <notebook-name>.ipynb on each
# save.  This can also be set with the short `--script` flag.
# c.FileNotebookManager.save_script = False
