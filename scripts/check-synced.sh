#!/bin/bash

# sudo apt install jq
# $1 should be core ip
# $2 should be core port
CORE_STATE=$(curl -s "$1/info" | jq -r '.info.state')
SYNCED_STATE="Synced!"
# if not "Synced!" send "boo"
if [ "$CORE_STATE" != "$SYNCED_STATE" ]; then
  echo "boo"
  # otherise print 0
else
  echo 0
fi
