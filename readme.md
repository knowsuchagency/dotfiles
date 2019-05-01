## [base xonsh config](etc/xonshrc.py)

This file's contents would be in `/etc/xonshrc`.

The `.py` suffix is just for syntax highlighting.

## [user xonsh config](xonshrc.py)

This file's contents would be in `~/xonshrc`.

The base config will be loaded prior to the user config.

Again, the `.py` suffix is only for syntax highlighting.

## misc

In the [`.gitignore`](.gitignore) file,
I've ignored `env.xsh` and `atlassian.xsh`.

Those files are imported from the user config.

* `env.xsh` -- defines common environment variables
* `atlassian.xsh` -- for work-specific environment variables and utilities