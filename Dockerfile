FROM napnap75/rpi-alpine-base:latest

# Install dependencies
RUN apk add py-pip \
  && pip install --upgrade pip \
  && pip install gandi.cli

# Add and run the update script
ADD updatedns.sh /usr/bin/updatedns.sh
RUN chmod +x /usr/bin/updatedns.sh
CMD /usr/bin/updatedns.sh
