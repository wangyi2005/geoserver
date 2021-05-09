FROM ubuntu:latest
ENV method=chacha20-ietf-poly1305 password=123-456-789 SOCVER=1.10.9 V2PVER=1.3.1
ADD entrypoint.sh /entrypoint.sh

RUN \
    apt-get update  && \
    apt-get install -y wget && \
    apt-get clean  && \
    mkdir -m 777 /ss && \
    chmod +x /entrypoint.sh

ENTRYPOINT  /entrypoint.sh 

EXPOSE 8080
