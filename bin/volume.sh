#!/bin/bash

# Configuration
STEP="1"
UNIT="%"   # dB, %, etc.

# Set volume
SETVOL="/usr/bin/amixer set Master "

case "$1" in
    "up")
          $SETVOL $STEP$UNIT+
          ;;
  "down")
          $SETVOL $STEP$UNIT-
          ;;
  "mute")
          $SETVOL toggle
          ;;
esac

# Get current volume and (off) state
VOLUME=$(amixer get Master | grep 'Left:' | cut -d ' ' -f 7 | sed -e 's/[^0-9]//g')
STATE=$(amixer get Master | grep 'Left:' | grep -o "\[off\]")

# Run volnoti if it has not been executed yet
pgrep -x volnoti > /dev/null || volnoti

# Show volume with volnoti OSD
if [[ -n $STATE ]]; then
  volnoti-show -m
else
  volnoti-show $VOLUME
fi

exit 0
