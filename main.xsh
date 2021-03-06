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
    '/Library/TeX/texbin',
    # dotnet
    '/usr/local/share/dotnet',
    # rust
    '~/.cargo/bin',
    # nim
    '~/.nimble/bin',
    # openjdk
    '/usr/local/opt/openjdk/bin',
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
    def cleanup():

        path = Path.cwd()

        paths_to_unlink = list(path.rglob("* 2"))

        if not paths_to_unlink:

            print("no duplicates to clean up")

            return

        for p in paths_to_unlink:

            print(p)

        unlink = input("Unlink the above files? y/N")

        print(f"{unlink=}")

        print(f'{unlink.lower().strip().startswith("y")=}')

        if unlink.lower().strip().startswith("y"):

            for p in paths_to_unlink:

                print(f"unlinking {p}")

                p.unlink()

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

    aliases['dc'] = 'docker-compose'
 
    aliases['gs'] = 'git status'
    aliases['gc'] = 'git commit'
    aliases['gcm'] = 'git commit -m'
    aliases['gd'] = 'git diff'
    aliases['ga'] = 'git add'
    aliases['gp'] = 'git push'
    aliases['gri'] = 'git rebase -i master'
    aliases['rebase'] = 'git pull --rebase origin master'
    aliases['rebase-prefer-ours'] = 'git pull --rebase -Xtheirs origin master'
    aliases['untracked'] = 'git ls-files --others --exclude-standard'
    aliases['pipx'] = '/usr/local/bin/python3 -m pipx'
    aliases['tf'] = 'terraform'

@alias
def docker_kill_all():
    for container in $(docker ps -q).splitlines():
        docker kill @(container)

@alias
def flush_dns_cache():
    """Flush OS dns cache."""
    sudo killall -HUP mDNSResponder; sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache

@alias
def set_symlinks():
    """Configure symlinks from icloud to $HOME"""
    # ln -s '~/Library/Mobile Documents/com~apple~CloudDocs/credentials' ~/.credentials
    # ln -s '~/Library/Mobile Documents/com~apple~CloudDocs/projects' ~/projects
    for symlink in ('.credentials', 'projects'):
        dest = Path(Path.home(), symlink)
        if not dest.exists():
            source = Path(
                Path.home(),
                'Library',
                'Mobile Documents',
                'com~apple~CloudDocs',
                symlink.lstrip('.')
            )
            os.symlink(source, dest)


def set_xontribs():
    $VOX_DEFAULT_INTERPRETER = '/usr/local/bin/python3'
    xontrib load vox
