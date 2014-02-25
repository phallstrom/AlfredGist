#!/bin/bash

PREF_DIR="$HOME/Library/Application Support/Alfred 2/Workflow Data/pjkh.gist"

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

If you want to use this workflow with a private Github installation
you must enter the hostname of your Github server when asked. By default
this workflow will use api.github.com.

EOT

printf "Please enter your GitHub server [api.github.com]: "
read server
if [[ -z "$server" ]]; then
  server="api.github.com"
fi

printf "Please enter your GitHub username: "
read username


json=`\
  curl \
  --silent \
  --user $username \
  --data "{\"scopes\":[\"gist\"],\"note\":\"Gist for AlfredApp\"}" \
  https://$server/authorizations \
`

token=$(get_json_key "token" "$json")

echo ""
echo "------------------------------------------------"
echo ""
if [[ -n "$token" ]]; then
  set_option "token" "$token"
  set_option "server" "$server"
  save_settings
  echo "Token has been retrieved and saved."
  echo "Server has been saved."
  echo "You're all set to gist!"
else
  echo "ERROR: An API error occured."
  echo ""
  echo "$token"
fi
echo ""
