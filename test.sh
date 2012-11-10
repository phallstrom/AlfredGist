#!/bin/bash

source functions.sh

function ensure
{
  if [[ "$1" != "$2" ]]; then
    echo "Expected '$2' to equal '$1'"
    caller
    exit
  fi
}

# 
# File only
#
parse_cli 
ensure "$file" ""
ensure "$description" ""

parse_cli file.ext
ensure "$file" "file.ext"
ensure "$description" ""

parse_cli -
ensure "$file" ""
ensure "$description" ""

parse_cli .ext
ensure "$file" "gist.ext"
ensure "$description" ""

parse_cli ext
ensure "$file" "gist.ext"
ensure "$description" ""

# 
# File and Description 
#
parse_cli file.ext lorem ipsum
ensure "$file" "file.ext"
ensure "$description" "lorem ipsum"

parse_cli - lorem ipsum
ensure "$file" ""
ensure "$description" "lorem ipsum"

parse_cli .ext lorem ipsum
ensure "$file" "gist.ext"
ensure "$description" "lorem ipsum"

parse_cli ext lorem ipsum
ensure "$file" ""
ensure "$description" "ext lorem ipsum"

# 
# File, an actual one
#
parse_cli "../Gist/test.sh"
ensure "$file" "test.sh"
ensure "$description" ""
ensure "$content" "`cat $0`"


# 
# Option: p, public, private
#
public="true"
parse_cli p
ensure "$public" "false"

public="true"
parse_cli private
ensure "$public" "false"

public="false"
parse_cli p
ensure "$public" "true"

public="false"
parse_cli public
ensure "$public" "true"


#
#
#
echo "All tests passed."
