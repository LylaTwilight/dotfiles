#!/bin/bash

status=$(playerctl status)

if [[ $status == "Stopped" ]]; then
    echo "󰓛 Stopped"
    exit 1
fi

if [[ $status == "Playing" ]]; then
    echo "󰐊 Playing"
    exit 1
fi

if [[ $status == "Paused" ]]; then
    echo "󰏤 Paused"
    exit 1
fi
