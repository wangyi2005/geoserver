#FROM heroku/heroku:20
FROM ubuntu:latest
ENV method=chacha20-ietf-poly1305 password=123-456-789 SSVER=1.10.9 v2pVER=1.3.1
ADD entrypoint.sh /entrypoint.sh

RUN \
    apt-get update  && \
    apt-get install -y wget && \
    mkdir -m 777 /ss && \
    chmod +x /entrypoint.sh

ENTRYPOINT  /entrypoint.sh 

EXPOSE 8080
