#!/usr/bin/env python3

from pathlib import Path


XONSH_RC = Path(Path.home(), '.xonshrc')

BODY = """
from contextlib import contextmanager
from pathlib import Path
import os

main_parent_dir = Path(Path.home(), 'projects', 'dotfiles')

@contextmanager
def _cd(path):
    cwd = os.getcwd()
    os.chdir(path)
    yield
    os.chdir(cwd)

with _cd(main_parent_dir):
    from main import *

    set_path()
    set_prompt()
    set_aliases()
    set_xontribs()

    env_file = Path(main_parent_dir, 'env.xsh')

    if not env_file.exists():
        env_file.write_text('...')

    work_file = Path(main_parent_dir, 'work.xsh')

    if not work_file.exists():
        work_file.write_text('...')

    from env import *
    from work import *

""".lstrip()

XONSH_RC.write_text(BODY)
