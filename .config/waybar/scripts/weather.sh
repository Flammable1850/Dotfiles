#!/bin/bash
LOCATION="Leidschendam-Voorburg"
WTTR=$(LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 curl -s "wttr.in/${LOCATION}?format=%t" 2>/dev/null)

if [[ -z "$WTTR" ]]; then
  echo '{"text": "⛅ --°C", "tooltip": "no data"}'
  exit 0
fi

TEMP=$(echo "$WTTR" | tr -d '[:space:]')
TOOLTIP=$(LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 curl -s "wttr.in/${LOCATION}?format=%l:+%C+%t+(%f)%0A💧+%h+💨+%w" 2>/dev/null | tr -d '\n' | sed 's/"/\\"/g')

printf '{"text": "⛅ %s", "tooltip": "%s"}\n' "$TEMP" "$TOOLTIP"