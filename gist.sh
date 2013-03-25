#!/bin/bash

source functions.sh
load_settings
parse_cli $* 

if [[ -z "$token" && "$action" != "setup" && "$action" != "help" ]]; then
  echo "FIXME"
  exit
fi

case $action in
  help)
    open "https://github.com/phallstrom/AlfredGist#usage"
    exit
    ;;
  setup)
    setup
    exit
    ;;
  configure)
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
      echo_item "gist_config_token" "$token" "no" "" "Your API access token is" "$token" 
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
