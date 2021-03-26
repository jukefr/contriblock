# contriblock

a bash script to block all the contributors from a specific github repository

## dependencies
this is a bash script (not shell)

[jq](https://stedolan.github.io/jq/) is also required

## usage
```bash
$ bash script.sh TOKEN user/repository (page) (page_size)
```

`page` defaults to 1

`page_size` defaults to 10 and GitHub allows 100 maximum.

GitHub token can be generated here: https://github.com/settings/tokens/new

All blocked logins will get appended to `BLOCKED.txt` where the script is ran.
