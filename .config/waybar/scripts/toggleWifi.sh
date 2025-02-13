#!/bin/bash

# Check the Wifi status
wifi_status=$(nmcli radio wifi)

# if it's enabled, turn off and vice versa
if [ "$wifi_status" == "enabled" ]; then
    nmcli radio wifi off
else
    nmcli radio wifi on
fi