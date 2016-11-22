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
echo "--- GANDI_DOMAIN=$GANDI_DOMAIN"
gandi record list -f json $GANDI_DOMAIN | jq '.[] | select(.name == "$GANDI_HOST")' > tmp_json
echo "--- current_config="
cat tmp_json
echo "--- ttl=$(cat tmp_json | jq '.ttl')"
echo "--- type=$(cat tmp_json | jq -r '.type')"
current_ip=$(cat tmp_json | jq -r '.value')
echo "The current registered IP address is: '$current_ip'"

# If they do not match, change it (and keep the TTL and TYPE)
if [[ "$my_ip" != "$current_ip" ]]; then
  host_string="$GANDI_HOST $(cat tmp_json | jq '.ttl') IN TYPE $(cat tmp_json | jq -r '.type')"
echo "--- host_string=$host_string"
  echo "Updating the record with: '$host_string $my_ip'"
  gandi record update -r "$host_string $current_ip" --new-record "$host_string $my_ip"  $GANDI_DOMAIN 
fi
