#!/usr/bin/env roundup
source tests/helper.sh

describe "configuring options"

before() {
  server="api.github.com"
  token="12345"
  public="true"
  copy_url="true"
  save_settings
}

after() {
  rm -f "$our_dir/config"
}

it_defaults_when_setting_server_with_no_value() {
  set_option "server" ""
  test "$server" = "api.github.com"
}

it_sets_server_to_value() {
  set_option "server" "server999"
  test "$server" = "server999"
}

it_errors_when_setting_token_with_no_value() {
  bash gist.sh configure token | grep "ERROR"
}

it_sets_token_to_value() {
  set_option "token" "999"
  test "$token" = "999"
}

it_errors_when_setting_public_to_bad_value() {
  bash gist.sh configure public | grep "ERROR"
  bash gist.sh configure public foo | grep "ERROR"
}

it_sets_public_to_true() {
  set_option "public" "true"
  test "$public" = "true"
}

it_sets_public_to_false() {
  set_option "public" "false"
  test "$public" = "false"
}

it_errors_when_setting_copy_url_to_bad_value() {
  bash gist.sh configure copy_url | grep "ERROR"
  bash gist.sh configure copy_url foo | grep "ERROR"
}

it_sets_copy_url_to_true() {
  set_option "copy_url" "true"
  test "$copy_url" = "true"
}

it_sets_copy_url_to_false() {
  set_option "copy_url" "false"
  test "$copy_url" = "false"
}

it_errors_when_passing_invalid_key() {
  bash gist.sh configure invalid bogus | grep "ERROR"
}

