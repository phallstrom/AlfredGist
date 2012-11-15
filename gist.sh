#!/bin/bash

source functions.sh
load_settings
parse_cli $* 

if [[ -z "$token" && "$action" != "setup" ]]; then
  echo "ERROR: Extension isn't setup."
  echo "Please type 'gist setup' to get going!"
  exit
fi

case $action in
  help)
    echo "Launching Help..."
    open "https://github.com/phallstrom/AlfredGist#usage"
    exit
    ;;
  setup)
    echo "Launching Terminal to run setup script..."
    setup
    exit
    ;;
  option)
    set_option "$key" "$val"
    save_settings
    echo "Option '$key' has been set to '$val' and saved."
    exit
    ;;
  gist)
    if [[ -z "$content" ]]; then
      echo "ERROR: No content to gist."
      echo "Perhaps the $content_from is blank?"
      exit
    fi

    result=$(create_gist "$file" "$description" "$content")

    if [[ ! "$result" =~ ^http ]]; then
      echo "ERROR: An API error occured."
      echo ""
      echo $result
      exit
    fi

    if [[ "$copy_url" = "true" ]]; then
      echo $result | pbcopy
      echo "Gist URL has been copied to the clipboard."
    fi

    open $result
    ;;
  *)
    echo "ERROR: Unknown action '$action'."
    ;;
esac
