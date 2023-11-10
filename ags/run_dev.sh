#!/bin/bash

WORKDIR="$HOME/.config/ags"

trap "pkill -f ags" INT

function _ags() {
    pkill ags
    ags --inspector &
}

function _sass() {
    sassc "$WORKDIR/style/main.scss" "$WORKDIR/style.css"
}

debounce_secs=2.0
last_change=0
function _debounce() {
    current_time=$(date +%s.%N)
    if (( $(echo "$current_time - $last_change > $debounce_secs" | bc -l) )); then
        last_change=$current_time
        _ags
    fi
}

_sass
_ags
inotifywait --quiet --monitor --event create,modify,delete --recursive $WORKDIR | while read DIRECTORY EVENT FILE; do
    file_extension=${FILE##*.}
    case $file_extension in
        js|ts)
            echo "reloading JS..."
            _debounce
            ;;
        scss)
            echo "reloading SCSS..."
            _sass
            ags --run-js "ags.App.resetCss(); ags.App.applyCss('style.css');" #&>/dev/null  
            ;;
    esac
done
