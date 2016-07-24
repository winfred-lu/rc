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

# Decide the icon according to the volume
icon=""
if [[ -n $STATE ]]; then
  icon="audio-volume-muted"
else
  if [ $VOLUME -lt 33 ]; then
    icon="audio-volume-low"
  elif [ $VOLUME -lt 67 ]; then
    icon="audio-volume-medium"
  else
    icon="audio-volume-high"
  fi
fi

# Desktop notify to display the volume
notify-send "Volume" -i $icon -h int:value:$VOLUME -h string:synchronous:volume

exit 0
