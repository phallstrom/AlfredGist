#!/usr/bin/env roundup
source tests/helper.sh

describe "load/save options"

before() {
  rm -f "$our_dir/config"
  mkdir "/tmp/alfred-gist-shared-config-dir"
}

after() {
  rm -f "$our_dir/config"
  rm -rf "/tmp/alfred-gist-shared-config-dir"
}

it_loads_default_settings() {
  load_settings
  test "$server"   = "api.github.com"
  test "$token"    = ""
  test "$public"   = "false"
  test "$copy_url" = "true"
  test "$shared_config_dir" = ""
}

it_saves_settings() {
  server="server123"
  token="token123"
  public="public123"
  copy_url="copy_url123"
  shared_config_dir="/tmp/alfred-gist-shared-config-dir"
  save_settings
  unset server token public copy_url shared_config_dir
  load_settings
  test "$server"   = "server123"
  test "$token"    = "token123"
  test "$public"   = "public123"
  test "$copy_url" = "copy_url123"
  test "$shared_config_dir" = "/tmp/alfred-gist-shared-config-dir"
}
