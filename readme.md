## [main.xsh](main.xsh)

This module is where all the real logic is stored.

## `xonshrc`

The following code should be placed in `~/.xonshrc`:

```python
from contextlib import contextmanager
from pathlib import Path
import os

# the parent directory of where we have our main logic stored
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

    # env variables are stored here
    from env import *
    # work stuff
    from atlassian import *
```


## misc

In the [`.gitignore`](.gitignore) file,
I've intentionally ignored `env.xsh` and `atlassian.xsh`.

* `env.xsh` -- defines common environment variables
* `atlassian.xsh` -- for work-specific environment variables and utilities