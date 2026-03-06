#!/bin/sh

# ============================================================================>

address=$(ibus address)
watch_exprs=$(cat <<EOF
interface='org.freedesktop.IBus.Engine',member='UpdateProperty'
EOF
)

# en='󰬴'
# kr='󱌳'

en=$(printf '{"text": "en", "alt": "en", "tooltip": "영어 (English)"}')
kr=$(printf '{"text": "kr", "alt": "kr", "tooltip": "한국어 (Korean)"}')

# ============================================================================>

echo $en

dbus-monitor --address $address $watch_exprs 2>/dev/null | \
    while read -r line; do
        if echo "$line" | grep -q 'string "한"'; then
            echo $kr
        elif echo "$line" | grep -q 'string "EN"'; then
            echo $en
        fi
    done

# ============================================================================>
