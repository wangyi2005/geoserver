FROM ubuntu:latest
ENV method=chacha20-ietf-poly1305 password=123-456-789 SSVER=1.10.9 v2pVER=1.3.1

RUN mkdir -m 777 /ss
RUN apt-get install wget
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh 
ENTRYPOINT  /entrypoint.sh 

EXPOSE 8080
