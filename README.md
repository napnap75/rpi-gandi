Docker image to update Gandi DNS

![Gandi](https://www.gandi.net/apple-touch-icon-114x114.png)

# Status
[![Build status](https://travis-ci.org/napnap75/rpi-gandi.svg?branch=master)](https://travis-ci.org/napnap75/rpi-gandi) [![Image size](https://images.microbadger.com/badges/image/napnap75/rpi-gandi.svg)](https://microbadger.com/images/napnap75/rpi-gandi "Get your own image badge on microbadger.com") [![Github link](https://assets-cdn.github.com/favicon.ico)](https://github.com/napnap75/rpi-gandi) [![Docker hub link](https://www.docker.com/favicon.ico)](https://hub.docker.com/r/napnap75/rpi-gandi/)


# Content
This image is based [my own Alpine Linux base image](https://hub.docker.com/r/napnap75/rpi-alpine-base/).

This image contains :

- [Gandi CLI](https://github.com/Gandi/gandi.cli) python scripts to manage the Gandi API.

# Usage
Use this image to update a DNS record to the current IP of the host: `docker run -e GANDI_API_KEY="YOUR GANDI API KEY" -e GANDI_HOST="THE HOST NAME IN THE GANDI DOMAIN" -e GANDI_DOMAIN="YOUR GANDI DOMAIN" --name gandi napnap75/rpi-gandi`

Every 5 minutes, the image will automatically check the current IP address of the host and, if necessary, update the DNS.
