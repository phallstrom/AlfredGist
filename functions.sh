#!/bin/bash

OUR_DIR=$(cd $(dirname "$0"); pwd)
PREF_DIR="$HOME/Library/Application Support/Alfred 2/Workflow Data/pjkh.gist"
[[ ! -d "$PREF_DIR" ]] && mkdir -p "$PREF_DIR" 2>/dev/null

function echo_start_items() {
  echo '<?xml version="1.0"?>'
  echo '<items>'
}

function echo_end_items() {
  echo '</items>'
}

function echo_item() { # uid, arg, valid, autocomplete, title, subtitle, icon
  echo "<item uid='$1' arg='$2' valid='$3' autocomplete='$4'>"
  echo "<title>$5</title>"
  echo "<subtitle>$6</subtitle>"
  echo "<icon>${7-icon.png}</icon>"
  echo "</item>"
}


#
# Set default settings, then load user's custom settings if config file exists.
#
function load_settings
{
  token=""
  public="false"
  copy_url="true"
  if [[ -r "$PREF_DIR/config" ]]; then
    source "$PREF_DIR/config"
  fi
}

#
#
#
function save_settings
{
  cat << EOT > "$PREF_DIR/config"
token="$token"
public="$public"
copy_url="$copy_url"
EOT
}

#
#
#
function set_option
{
  local key=$1
  local val=$2

  case $key in
    token)
      if [[ -z "$val" ]]; then
        echo "ERROR: Value must be a non-zero length string. Try 'gist setup'."
        exit
      else
        token=$val
      fi
      ;;
    public)
      if [[ ! "$val" =~ ^(true|false)$ ]]; then
        echo "ERROR: Value must be 'true' or 'false'."
        exit
      fi
      public=$val
      ;;
    copy_url)
      if [[ ! "$val" =~ ^(true|false)$ ]]; then
        echo "ERROR: Value must be 'true' or 'false'."
        exit
      fi
      copy_url=$val
      ;;
    *)
      echo "ERROR: Invalid option '$key'. Valid options are:"
      echo "token [string]"
      echo "public [true|false]"
      echo "copy_url [true|false]"
      ;;
  esac

}



#
# Parse the command line and set all global variables we will need to complete
# the script.
#
function parse_cli()
{
  action=""
  file=""
  description=""
  content=""
  content_from=""

  local arg1
  local arg2
  local arg3

  IFS=" " read arg1 arg2 arg3 <<< $*

  # If there is a single argument that is a readable file then create a gist
  # using that file and it's contents.
  # if [[ $# -eq 1 && -r $arg1 ]]; then
  #   action="gist"
  #   file=${arg1##*\/}
  #   content=`cat "$arg1"`
  #   content_from="file"
  #   return
  # fi

  case $arg1 in
    help)
      action="help"
      return
      ;;
    setup)
      action="setup"
      return
      ;;
    configure)
      action="configure"
      key=$arg2
      val=$arg3
      return
      ;;
    p)
      if [[ "$public" = "false" ]]; then
        set_option "public" "true"
      else
        set_option "public" "false"
      fi
      ;;
    public)
      set_option "public" "true"
      ;;
    private)
      set_option "public" "false"
      ;;
    *)
      if [[ -n "$arg3" ]]; then
        arg3="$arg2 $arg3"
      else
        arg3=$arg2
      fi
      arg2=$arg1
      ;;
  esac

  file=$arg2
  description=$arg3

  if [[ -n "$description" && ! "$file" =~ \. && "$file" != "-" ]]; then
    description="$file $description"
    file="-"
  fi

  if [[ -n "$file" ]]; then
    if [[ "$file" = "-" ]]; then
      file=""
    elif [[ "$file" =~ ^\.[^.]+$ ]]; then
      file="gist$file"
    elif [[ ! "$file" =~ \. ]]; then
      file="gist.$file"
    fi
  fi
  
  action="gist"
  content="`pbpaste`"
  content_from="clipboard"
}


function setup
{
    osascript 2>&1 >/dev/null <<EOF
      tell application "Terminal"
        activate
        tell application "System Events"
          keystroke "t" using {command down}
        end tell
        do script with command "cd \"$OUR_DIR\" && bash setup.sh" in window 1
      end tell
EOF
}

#
# Usage:
#   val=$(get_json_key "key" "json string")
# 
# The quotes are critically important.
#
function get_json_key
{
  local key=$1
  local json=$2
  local val=''
  if [[ "$json" =~ \"$key\"\: ]]; then
    val=${json#*$key\":\ \"}
    val=${val%%\"*}
  fi
  echo $val
}

#
#
#
function create_gist
{
  file=$1
  description=$2
  content=$3

  file=${file//\\/\\\\}
  file=${file//\"/\\\"}

  description=${description//\\/\\\\}
  description=${description//\"/\\\"}

  content=${content//\\/\\\\}
  content=${content//\"/\\\"}
  content=${content//$'\t'/\\t}
  content=${content//$'\b'/\\b}
  content=${content//$'\f'/\\f}

  # Github does not care for \r...
  content=${content//$'\r\n'/\\n}
  content=${content//$'\r'/\\n}
  content=${content//$'\n'/\\n}

  json=`\
    curl \
    --silent \
    --header "Authorization: token $token" \
    --data "{\"description\":\"$description\",\"public\":$public,\"files\":{\"$file\":{\"content\":\"$content\"}}}" \
    https://api.github.com/gists \
  `

  gist_url=$(get_json_key "html_url" "$json")

  if [[ -n "$gist_url" ]]; then
    echo $gist_url
  else
    echo "$json"
  fi

}

