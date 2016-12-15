FROM napnap75/rpi-alpine-base:latest

# Install dependencies
RUN apk update \
  && apk add python py-pip jq curl \
  && pip install gandi.cli \
  && apk del py-pip \
  && rm -rf /var/cache/apk/*

# Add and run the update script
ADD updatedns.sh /usr/bin/updatedns.sh
RUN chmod +x /usr/bin/updatedns.sh
CMD /usr/bin/updatedns.sh
