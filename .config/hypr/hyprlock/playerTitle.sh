#!/bin/bash

title=$(playerctl metadata xesam:title)
max_len=32

if [[ -z $title ]]; then
    echo "nothing is playing rn"
    exit 1
fi

if [[ ${#title} -gt $max_len ]]; then
    echo "${title:0:$max_len}..."
else
    echo "$title"
fi
