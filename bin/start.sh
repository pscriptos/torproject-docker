#!/bin/bash
set -e

tor -f /etc/tor/torrc &

sleep 10

if [ -t 1 ]; then
  echo "Starte Nyx zur Überwachung von Tor..."
  nyx &
fi

exec privoxy --no-daemon /etc/privoxy/config
