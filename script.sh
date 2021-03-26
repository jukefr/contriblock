#!/usr/bin/env bash

# requires jq

# quick bash script to block all contributors of a specific repository
# contributions are welcome

# usage
# <command> $TOKEN $REPO $PAGE $COUNT

# Github username may only contain alphanumeric characters or hyphens.
# Github username cannot have multiple consecutive hyphens.
# Github username cannot begin or end with a hyphen.
# Maximum is 39 characters.
# Should be relatively safe :sweat-smile:

TOKEN="$1" # https://github.com/settings/tokens/new
REPO="$2"
PAGE="${3:-0}" # "basic resume"
COUNT="${4:-10}"

while true; do
  echo "Page $PAGE"
  PAGE=$((PAGE + 1))

  # https://docs.github.com/en/rest/reference/repos#list-repository-contributors
  # Name 		  Type 	    In 		  Description
  # accept 	  string 	  header 	Setting to application/vnd.github.v3+json is recommended.
  # owner 		string 	  path
  # repo 		  string 	  path
  # anon 		  string 	  query 	Set to 1 or true to include anonymous contributors in results.
  # per_page 	integer 	query 	Results per page (max 100).
  # page 		  integer 	query 	Page number of the results to fetch.
  LIST=$(curl -s -H "Authorization: token $TOKEN" \
    -G -d "per_page=$COUNT" -d "page=$PAGE" \
    "https://api.github.com/repos/$REPO/contributors")

  CURRENT_COUNT=$(echo "$LIST" | jq length)

  LOGINS=($(echo "$LIST" | jq -r ".[].login")) # not ideal but it works :shrug:

  # https://docs.github.com/en/rest/reference/users#block-a-user
  # Name 		  Type 	  In 		  Description
  # accept 	  string 	header 	Setting to application/vnd.github.v3+json is recommended.
  # username 	string 	path
  for LOGIN in "${LOGINS[@]}"; do
    curl -s -H "Authorization: token $TOKEN" \
      -X PUT \
      "https://api.github.com/user/blocks/$LOGIN"
    echo "$LOGIN" >>BLOCKED.txt
  done

  if [ "$CURRENT_COUNT" -ne "$COUNT" ]; then # we are done.
    echo "Done. See BLOCKED.txt for login list."
    exit
  fi
done
