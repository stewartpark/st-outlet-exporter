#!/usr/bin/env bash

if [[ ! -z "$SMARTTHINGS_TOKEN" ]]; then
    export SMARTTHINGS_CLI_TOKEN=$SMARTTHINGS_TOKEN
else
    echo "Please set SMARTTHINGS_TOKEN as your Samsung SmartThings personal token."
    exit 1;
fi

if [[ -z "$SMARTTHINGS_OUTLET_NAME" ]]; then
    echo "Please set SMARTTHINGS_OUTLET_NAME as your smart outlet's label/name you set on the app."
    exit 1;
fi

mkdir -p /www

# Launch the webserver as a daemon
busybox httpd -p 80 -h /www

# Minutely metric generation for the http server
while true; do
    export WATT=$(node cli.js status "$SMARTTHINGS_OUTLET_NAME" | grep value | head -n 1 | awk '{ print $2 }')
    touch /tmp/metrics
    echo "HELP smartthings_outlet_watt Power consumption measured at the smart outlet in Watts" >> /tmp/metrics
    echo "TYPE smartthings_outlet_watt gauge" >> /tmp/metrics
    echo "smartthings_outlet_watt{name=$SMARTTHINGS_OUTLET_NAME} $WATT" >> /tmp/metrics
    mv /tmp/metrics /www/metrics
    sleep 60
done
