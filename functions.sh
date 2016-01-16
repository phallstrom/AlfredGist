#!/bin/bash

OUR_DIR=$(cd $(dirname "$0"); pwd)
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
  server="api.github.com"
  token=""
  public="false"
  copy_url="true"
  shared_config_dir=""
  if [[ -r "$PREF_DIR/config" ]]; then
    source "$PREF_DIR/config"
  fi
  if [[ -n "$shared_config_dir" && -r "$shared_config_dir/config" ]]; then
    source "$shared_config_dir/config"
  fi
}

#
#
#
function save_settings
{
  if [[ -n "$shared_config_dir" ]]; then
  cat << EOT > "$shared_config_dir/config"
server="$server"
token="$token"
public="$public"
copy_url="$copy_url"
EOT
  cat << EOT > "$PREF_DIR/config"
shared_config_dir="$shared_config_dir"
EOT
  else
  cat << EOT > "$PREF_DIR/config"
server="$server"
token="$token"
public="$public"
copy_url="$copy_url"
EOT
  fi

}

#
#
#
function set_option
{
  local key=$1
  local val=$2

  case $key in
    shared_config_dir)
      if [[ -z "$val" ]]; then
        shared_config_dir=""
      elif [[ ! -d "$val" ]]; then
        echo "ERROR: '$val' must be an existing directory."
        exit
      else
        shared_config_dir=$val
      fi
      ;;
    server)
      if [[ -z "$val" ]]; then
        server="api.github.com"
      else
        server=$val
      fi
      ;;
    token)
      if [[ -z "$val" ]]; then
        echo "ERROR: Value must be a non-zero length string."
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
      echo "server [string]"
      echo "shared_config_dir [string]"
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
  description=""
  anonymous="false"
  files=()
  contents=()

  local arg1
  local arg2
  local arg3

  IFS=" " read arg1 arg2 arg3 <<< $*

  case $arg1 in
    help)
      action="help"
      return
      ;;
    configure)
      action="configure"
      key=$arg2
      val=$arg3
      return
      ;;
    anon)
      anonymous="true"
      ;;
    a)
      anonymous="true"
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
    _files)
      for i in ${*:2}
      do
        action="gist"
        files=("${files[@]}" "${i##*\/}")
        contents=("${contents[@]}" "`cat "$i"`")
      done
      return
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
  files[0]=$file
  contents[0]=`pbpaste`
}

#
# Escape JSON string
#
function json_escape()
{
  echo -n "$1" | python -c 'import json,sys; print json.dumps(sys.stdin.read())'
}

#
#
#
function create_gist
{
  if [[ ${#contents[@]} -eq 0 ]]; then
    echo "ERROR: No content to gist."
    echo "Perhaps the $content_from is blank?"
    exit
  fi

  description=${description//\\/\\\\}
  description=${description//\"/\\\"}

  file_json=''

  for (( i = 0; i < ${#contents[@]}; i++ ))
  do
    file=${files[$i]}
    content=${contents[$i]}

    [[ ${#contents[@]} -gt 1 ]] && file="$i-$file"

    file=${file//\\/\\\\}
    file=${file//\"/\\\"}

    content="$(json_escape "$content")"

    file_json="$file_json,\"$file\":{\"content\":$content}"

  done


  if [[ "$anonymous" = "false" ]]; then
    auth_header="Authorization: token $token"
  else
    auth_header=""
  fi

  json=`\
    curl \
    --silent \
    --header "$auth_header" \
    --data "{\"description\":\"$description\",\"public\":$public,\"files\":{${file_json#,}}}" \
    https://$server/gists \
  `

  gist_url=$(get_json_key "html_url" "$json")

  if [[ -n "$gist_url" ]]; then
    if [[ "$copy_url" = "true" ]]; then
      echo -n $gist_url | pbcopy
      echo "Gist URL has been copied to the clipboard."
    fi
    open $gist_url
  else
    echo "ERROR: An API error occured."
    echo ""
    echo "$json"
    exit
  fi


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

