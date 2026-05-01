#!/usr/bin/env bash

FILE="$HOME/.config/niri/toggles/gaps.kdl"

if [ -f "$FILE" ]; then
  rm "$FILE"
else
  mkdir -p "$(dirname "$FILE")"
  cat <<EOF > "$FILE"
layout {
    gaps 0
    border {
        width 1
    }
}

window-rule {
    geometry-corner-radius 0
}
EOF
fi

niri msg action reload-config
