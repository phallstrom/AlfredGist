#!/bin/bash

source functions.sh
load_settings

cat << EOT

Gist for AlfredApp Setup
=========================================================================

This script will make a request to the GitHub API and get
authorization to create Gists on your behalf.  Note that this also
grants permission edit and delete Gists, but we don't do that. 
Just wanted you to know.

You will need to provider your GitHub username and password. These are
passed to curl and used to authenticate your request.  This request is
made over SSL.

If an error occurs the response from GitHub will be returned.

If successful, a token will be set.  You should also see an entry for 
"Gist for AlfredApp" at the following URL:

  https://github.com/settings/applications

EOT

printf "Please enter your GitHub username: "
read username

json=`\
  curl \
  --silent \
  --user $username \
  --data "{\"scopes\":[\"gist\"],\"note\":\"Gist for AlfredApp\"}" \
  https://api.github.com/authorizations \
`

token=$(get_json_key "token" "$json")

echo ""
echo "------------------------------------------------"
echo ""
if [[ -n "$token" ]]; then
  set_option "token" "$token"
  save_settings
  echo "Token has been retrieved and saved."
  echo "You're all set to gist!"
else
  echo "ERROR: An API error occured."
  echo ""
  echo "$token"
fi
echo ""
