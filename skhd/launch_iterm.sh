#!/bin/zsh

set -e

osascript - <<EOF
if application "iTerm" is not running then
    activate application "iTerm"
else
    tell application "iTerm"
        create window with default profile
        activate
    end tell
end if
EOF
