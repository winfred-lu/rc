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
#notify-send "Volume" -i $icon -h int:value:$VOLUME -h string:synchronous:volume

uid_file="/tmp/volume_notify_${USER}"
if [ -s $uid_file ]; then
  uid=`cat $uid_file`
else
  uid=1
fi

# Use gdbus before libnotify is patched for the replacement cabailities.
# This replaces the existing notification with the same $uid,
# which prevents the flooding notifications.
gdbus call --session --dest org.freedesktop.Notifications \
  --object-path /org/freedesktop/Notifications \
  --method org.freedesktop.Notifications.Notify \
  "Volume" "$uid" $icon "" " " \[\] "{'value': <$VOLUME>}" 3000 \
  | sed -r 's/\(uint32 (.+)\,\)/\1/' > $uid_file

exit 0
