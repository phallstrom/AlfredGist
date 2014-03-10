#!/usr/bin/env roundup
source tests/helper.sh

describe "command line parsing"

before() {
  unset action
  unset description
  unset files
  unset contents
}

it_parses_with_a_single_filename() {
  parse_cli _files tests/test_cli.sh
  test "$action"       = "gist"
  test "${files[0]}"   = "test_cli.sh" 
}

it_parses_help() {
  parse_cli help
  test "$action"      = "help"
}

it_parses_configure() {
  parse_cli configure somekey someval
  test "$action"      = "configure"
  test "$key"         = "somekey"
  test "$val"         = "someval"
}

it_parses_p_when_public_is_true() {
  public="true"
  parse_cli p
  test "$public" = "false"
}

it_parses_p_when_public_is_false() {
  public="false"
  parse_cli p
  test "$public" = "true"
}

it_parses_public() {
  public="false"
  parse_cli public
  test "$public" = "true"
}

it_parses_private() {
  public="true"
  parse_cli private
  test "$public" = "false"
}

it_parses_nonanonymous() {
  parse_cli
  test "$anonymous" = "false"
}

it_parses_a() {
  parse_cli a
  test "$anonymous" = "true"
}

it_parses_anon() {
  parse_cli anon
  test "$anonymous" = "true"
}


it_parses_with_zero_arguments() {
  parse_cli
  test "$action"       = "gist"
  test "${files[0]}"         = ""
  test "$description"  = ""
}

it_parses_with_p_and_file() {
  parse_cli private file.rb
  test "$action"       = "gist"
  test "${files[0]}"         = "file.rb"
  test "$description"  = ""
  test "$public"       = "false" 
}

it_parses_with_p_and_file_and_desc() {
  parse_cli private file.rb desc
  test "$action"       = "gist"
  test "${files[0]}"         = "file.rb"
  test "$description"  = "desc"
  test "$public"       = "false" 
}

it_parses_with_file() {
  parse_cli private file.rb
  test "$action"       = "gist"
  test "${files[0]}"         = "file.rb"
  test "$description"  = ""
}

it_parses_with_file_and_desc() {
  parse_cli private file.rb desc
  test "$action"       = "gist"
  test "${files[0]}"         = "file.rb"
  test "$description"  = "desc"
  test "$public"       = "false" 
}

it_parses_with_ext() {
  parse_cli ext
  test "$action"       = "gist"
  test "${files[0]}"         = "gist.ext"
  test "$description"  = ""
}

it_parses_with_dotext() {
  parse_cli .ext
  test "$action"       = "gist"
  test "${files[0]}"         = "gist.ext"
  test "$description"  = ""
}

it_parses_with_file_as_dash() {
  parse_cli -
  test "$action"       = "gist"
  test "${files[0]}"         = ""
  test "$description"  = ""
}

it_parses_with_dash_and_desc() {
  parse_cli - desc
  test "$action"       = "gist"
  test "${files[0]}"         = ""
  test "$description"  = "desc"
}

it_parses_with_dotext_and_desc() {
  parse_cli .ext desc
  test "$action"       = "gist"
  test "${files[0]}"         = "gist.ext"
  test "$description"  = "desc"
}

it_parses_with_ext_and_desc() {
  parse_cli ext desc
  test "$action"       = "gist"
  test "${files[0]}"         = ""
  test "$description"  = "ext desc"
}
