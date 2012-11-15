#!/usr/bin/env roundup
source tests/helper.sh

describe "load/save options"

before() {
  rm -f "$our_dir/config"
}

after() {
  rm -f "$our_dir/config"
}

it_loads_default_settings() {
  load_settings
  test "$token"    = ""
  test "$public"   = "false"
  test "$copy_url" = "true"
}

it_saves_settings() {
  token="token123"
  public="public123"
  copy_url="copy_url123"
  save_settings
  unset token public copy_url
  load_settings
  test "$token"    = "token123"
  test "$public"   = "public123"
  test "$copy_url" = "copy_url123"
}
