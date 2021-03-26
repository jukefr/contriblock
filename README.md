<div align="center">
  <a href="https://github.com/jukefr/contriblock">
  <img width="100%;"  src="https://user-images.githubusercontent.com/2154296/112618939-ff6a7380-8e26-11eb-9e18-e049a7a49817.png">
  </a>
  <br>
</div>

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

## api cache
from https://docs.github.com/en/rest/reference/repos#list-repository-contributors
```
This endpoint may return information that is a few hours old because the GitHub REST API v3 caches contributor data to improve performance.
```
