#!/usr/bin/env bash

PID=$(niri msg focused-window | awk '/PID:/ { print $2 }')
STATE=$(awk '/^State:/ { print $2 }' "/proc/$PID/status")

if [ "$STATE" = "T" ]; then
  kill -CONT "$PID"
else
  kill -STOP "$PID"
fi
