"""
This could be /etc/xonshrc
"""

from functools import wraps
from pathlib import Path
from contextlib import contextmanager
import itertools as it
import json
import os


def alias(func=None, alternatives=None, as_=None):
    """
    Add the name of the function with underscores set to dashes (or stripped if at ends) as an alias.

    i.e. a function named hello_world is aliased to hello-world
                          _hello_ is aliased to hello
    """
    alternatives = [] if alternatives is None else alternatives

    def decorator(func):
        global aliases
        nonlocal alternatives, as_
        
        as_ = func.__name__.strip('_').replace('_', '-') if as_ is None else as_

        aliases[as_] = func
    
        for a in alternatives:
            aliases[a] = func

        @wraps(func)
        def inner(*args, **kwargs):
            func(*args, **kwargs)
        return inner

    if func is not None:
        return decorator(func)

    return decorator


@contextmanager
def _cd(path):
    cwd = os.getcwd()
    os.chdir(path)
    yield
    os.chdir(cwd)


def set_path(paths=()):
    defaults = [
    # pipx
    '~/.local/bin',
    # homebrew/other
    '/usr/local/bin',
    # mactex
    '/usr/local/texlive/2018/bin/x86_64-darwin',
    # dotnet
    '/usr/local/share/dotnet',
    # rust
    '~/.cargo/bin',
    ]

    paths = list(map(os.path.expanduser, (paths or defaults)))

    def is_venv_dir(path):
        return any(s in path for s in ['.virtualenvs/', 'venv/'])
    
    for p in $PATH:
        if p in paths:
            continue
        elif is_venv_dir(p):
            paths = [p] + paths
        else:
            paths.append(p)

    $PATH = paths


def set_prompt():

    def _get_error_code():
        global _

        try:
            error_code = _.rtn
            if error_code:
                return f'[{error_code}]'
        except (NameError, AttributeError):
            return None


    $PROMPT_FIELDS['error_code'] = _get_error_code

    $PROMPT = '{PURPLE}{env_name:{} }{WHITE}{short_cwd} {BLUE}-> {branch_color}{curr_branch}{NO_COLOR} {INTENSE_RED}{error_code:{} }'


def set_aliases():
    """"""

    @alias(alternatives=['docker-cleanup'])
    def docker_remove_clingons():
        """Remove dangling docker containers."""
        docker rmi -f @([l.strip() for l in !(docker images --quiet --filter "dangling=true").itercheck()])

    @alias(alternatives=['gpb'])
    def git_push_current_branch():
        """Push the current branch on to its remote counterpart."""
        git push origin @($(git branch | grep \* | cut -d ' ' -f2).strip())

    @alias
    def cpu_above(args):
        from pprint import pprint
        import argparse
        import psutil
        
        processes = []
        for p in psutil.process_iter():
            try:
                p.cpu_percent()
                processes.append(p)
            except psutil._exceptions.AccessDenied:
                continue
        
        sorted_procs = list(sorted(processes, key=lambda p: p.cpu_percent()))

        for p in sorted_procs:
            try:
                print(p, p.cpu_percent())
            except psutil._exceptions.ZombieProcess:
                continue

    def uninstall_all(cmd):
        def inner():
            packages = json.loads($(@(cmd) list --format json))
            names = [p['name'] for p in packages if p['name'] not in ('setuptools', 'pip', 'wheel')]
            for name in names:
                print(f'uninstalling {name}')
                $(@(cmd) uninstall @(name) -y)
        return inner

    for pip_cmd in ('pip', 'pip2', 'pip3', 'xpip'):
        aliases[f'{pip_cmd}-uninstall-all'] = uninstall_all(pip_cmd)

    aliases['p'] = 'python3'
    aliases['jl'] = ['jupyter', 'labdash']
    aliases['jn'] = ['jupyter', 'notebook']

    aliases['gs'] = 'git status'
    aliases['gc'] = 'git commit'
    aliases['gcm'] = 'git commit -m'
    aliases['gd'] = 'git diff'
    aliases['ga'] = 'git add'
    aliases['gp'] = 'git push'
    aliases['gri'] = 'git rebase -i master'
    aliases['rebase'] = 'git pull --rebase origin master'
    aliases['untracked'] = 'git ls-files --others --exclude-standard'

@alias
def docker_kill_all():
    for container in $(docker ps -q).splitlines():
        docker kill @(container)

def set_xontribs():
    $VOX_DEFAULT_INTERPRETER = '/usr/local/bin/python3'
    xontrib load vox
