FROM napnap75/rpi-alpine-base:latest

# Install dependencies
RUN apk add py-pip \
  && pip install --upgrade pip \
  && pip install gandi.cli \
  && gandi help record
  
