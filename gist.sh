#!/bin/bash

PREF_DIR="$HOME/Library/Application Support/Alfred 2/Workflow Data/pjkh.gist"

source functions.sh
load_settings
parse_cli $* 

if [[ -z "$token" && "$action" != "configure" && "$action" != "help" ]]; then
  echo "You need to setup and configure Gist. Type 'gist help' for details."
  exit
fi

case $action in
  help)
    open "https://github.com/phallstrom/AlfredGist#usage"
    exit
    ;;
  configure)

    newvalue=$(pbpaste | head -1 | iconv -c -t ASCII)

    if [[ -z "$key" && -z "$val" ]]; then
      echo_start_items
      if [[ "$public" = "true" ]]; then
        echo_item "gist_config_public" "configure public false" "yes" "" "Your gists are public by default." "Select to change the default to private."
      else
        echo_item "gist_config_public" "configure public true" "yes" "" "Your gists are private by default." "Select to change default to public."
      fi
      if [[ "$copy_url" = "true" ]]; then
        echo_item "gist_config_copy_url" "configure copy_url false" "yes" "" "The Gist URL is copied to your clipboard." "Select to not copy the URL."
      else
        echo_item "gist_config_copy_url" "configure copy_url true" "yes" "" "The Gist URL is not copied to your clipboard." "Select to copy the URL."
      fi
      echo_item "gist_config_token" "configure token $newvalue" "yes" "" "Your API access token is $token" "Select to change to '$newvalue'."
      echo_item "gist_config_server" "configure server $newvalue" "yes" "" "Your API server is $server" "Select to change to '$newvalue'."
      echo_end_items
      exit
    fi

    set_option "$key" "$val"
    save_settings
    echo "Gist configuration has been updated."
    exit
    ;;
  gist)
    create_gist
    ;;
  *)
    echo "ERROR: Unknown action '$action'."
    ;;
esac
