#!/usr/bin/env bash

FILE="$HOME/.config/niri/toggles/bar-smart-mode"

if [ -f "$FILE" ]; then
  rm "$FILE"
  noctalia msg bar-auto-hide-set off
  noctalia msg bar-layer-set top
  noctalia msg bar-reserve-toggle
else
  mkdir -p "$(dirname "$FILE")"
  touch "$FILE"
  noctalia msg bar-auto-hide-set on
  noctalia msg bar-layer-set overlay
  noctalia msg bar-reserve-toggle
fi
