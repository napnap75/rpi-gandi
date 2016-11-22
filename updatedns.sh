#!/bin/bash

# First check if the gandi cli is properly configured, otherwise configure it
if ! (gandi config get api.key >> /dev/null && gandi config get api.host >> /dev/null); then
  gandi config set api.host "https://rpc.gandi.net/xmlrpc/"
  gandi config set api.key "$GANDI_API_KEY"
fi

# Get my current IP
my_ip=$(curl -s https://api.ipify.org)
echo "My public IP address is: '$my_ip'"

# Get my currently registered IP
current_config=$(gandi record list -f json $GANDI_DOMAIN | jq '.[] | select(.name == "$GANDI_HOST")')
echo "--- current_config=$current_config"
echo "--- ttl=$(echo $current_config | jq '.ttl')"
echo "--- type=$(echo $current_config | jq -r '.type')"
current_ip=$(echo $current_config | jq -r '.value')
echo "The current registered IP address is: '$current_ip'"

# If they do not match, change it (and keep the TTL and TYPE)
if [[ "$my_ip" != "$current_ip" ]]; then
  host_string="$GANDI_HOST $(echo $current_config | jq '.ttl') IN TYPE $(echo $current_config | jq -r '.type')"
echo "--- host_string=$host_string"
  echo "Updating the record with: '$host_string $my_ip'"
  gandi record update -r "$host_string $current_ip" --new-record "$host_string $my_ip"  $GANDI_DOMAIN 
fi
