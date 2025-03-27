#!/usr/bin/env bash

# Set Waydroid properties (if Waydroid is available)
waydroid session stop
sleep 2

waydroid session start &
sleep 2

while true; do
    sleep 2
    status=$(waydroid status)
    if [[ "$status" == *"RUNNING"* ]]; then
      echo "Waydroid session started"
      break
    fi
		echo "Waydroid starting"
  done

waydroid prop set persist.waydroid.height 800
waydroid prop set persist.waydroid.width 400

