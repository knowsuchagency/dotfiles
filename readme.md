## [main.xsh](main.xsh)

Logic goes here

## `~/.xonshrc`

```python
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

    from env import *
    from work import *
```


## misc

* `env.xsh` -- common environment variables
* `work.xsh` -- work-related environment variables and utilities