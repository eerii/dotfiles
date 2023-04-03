#!/bin/zsh

set -e

osascript - <<EOF
if application "Warp" is not running then
    activate application "Warp"
else
    tell application "Warp"
        create window with default profile
        activate
    end tell
end if
EOF
