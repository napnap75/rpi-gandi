#!/bin/bash

my_ip=$(curl -s https://api.ipify.org)
echo "My public IP address is: $my_ip"

echo "--- Help for record list"
gandi help record list
echo "--- Try record list"
gandi record list $GANDI_DOMAIN
echo "--- Help for record update"
gandi help record update
