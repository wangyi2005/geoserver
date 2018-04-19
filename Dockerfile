FROM anapsix/alpine-java:8u172b11_server-jre

RUN apk add --no-cache curl  && \
    cd /tmp && \
    curl -L http://download.java.net/media/jai/builds/release/1_1_3/jai-1_1_3-lib-linux-amd64.tar.gz | tar xfz - && \
    curl -L http://download.java.net/media/jai-imageio/builds/release/1.1/jai_imageio-1_1-lib-linux-amd64.tar.gz  | tar xfz - && \
    mv /tmp/jai*/lib/*.jar $JAVA_HOME/jre/lib/ext/ && \
    mv /tmp/jai*/lib/*.so $JAVA_HOME/jre/lib/amd64/ && \
    rm -r /tmp/*
   

#-------------------------Geoserver 2.13-------------------------------
ENV GS_VERSION 2.13.0
ENV GEOSERVER_HOME /geoserver/geoserver-${GS_VERSION}

RUN mkdir -m 777 /geoserver && \
    cd /geoserver && \
    wget http://downloads.sourceforge.net/project/geoserver/GeoServer/${GS_VERSION}/geoserver-${GS_VERSION}-bin.zip && \
    unzip geoserver-${GS_VERSION}-bin.zip && \ 
    rm -rf geoserver-${GS_VERSION}-bin.zip && \
    chmod 777 /geoserver/geoserver-${GS_VERSION}/data_dir && \
    chmod 777 /geoserver/geoserver-${GS_VERSION}/logs

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh 
CMD /entrypoint.sh
EXPOSE 8080
