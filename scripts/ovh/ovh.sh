#!/usr/bin/env bash
#
# Post-installation Configuration Scripts
#
# First stage script for OVH dedicated servers
# - Get distro name
# - Check server is an OVH dedicated server
# - Download and execute appropriate scripts


# OVH dedicated servers are expected to run this script as "script"
EXPECT_SCRIPT_PATH="/tmp/script"

# Remote scripts URI root
URI_ROOT="https://raw.githubusercontent.com/"\
"moarbytes/post-config/master/"

# OS Release file
OSR_FILE="/etc/os-release"

# Secondary script file
NEXT_FILE=/tmp/next

exec_remote () {
  # 'raw.githubusercontent.com' domain may not clear HTTPS CA checks
  bash <(wget --no-check-certificate -O - $URI_ROOT$1)
  return $?
}


cfg_debian () {
  exec_remote "scripts/ovh/ovh_debian"
  exec_remote "scripts/debian/deb_host"
  exec_remote "scripts/debian/deb_lxc"
}


err() { cat <<< "${0##*/}: $@" 1>&2; }


main
