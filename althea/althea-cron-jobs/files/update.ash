#!/bin/ash
set -eux
CHANGED=false

opkg update

if opkg install althea-rust-binaries | grep -q 'Configuring'; then
  CHANGED=true
fi
if opkg install althea-babeld | grep -q 'Configuring'; then
  CHANGED=true
fi
if opkg install althea-cron-jobs | grep -q 'Configuring'; then
  CHANGED=true
fi

# https://wiki.openwrt.org/doc/howto/cron
# Note: To avoid infinite reboot loop, wait 70 seconds
# and touch a file in /etc so clock will be set
# properly to 4:31 on reboot before cron starts.
if CHANGED; then
sleep 70 && touch /etc/banner && reboot
fi