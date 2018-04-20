FROM anapsix/alpine-java:8u172b11_server-jre

# Install Java JAI libraries
RUN \
    apk add --no-cache ca-certificates curl && \
    cd /tmp && \
    curl -L http://download.java.net/media/jai/builds/release/1_1_3/jai-1_1_3-lib-linux-amd64.tar.gz | tar xfz - && \
    curl -L http://download.java.net/media/jai-imageio/builds/release/1.1/jai_imageio-1_1-lib-linux-amd64.tar.gz  | tar xfz - && \
    mv /tmp/jai*/lib/*.jar $JAVA_HOME/jre/lib/ext/ && \
    mv /tmp/jai*/lib/*.so $JAVA_HOME/jre/lib/amd64/ && \
    apk del curl && \
    rm -r /tmp/*

# Install geoserver
ENV GS_VERSION 2.13.0
ENV GEOSERVER_HOME /geoserver
RUN \
    cd /tmp && \
    wget -O geoserver.zip http://downloads.sourceforge.net/project/geoserver/GeoServer/${GS_VERSION}/geoserver-${GS_VERSION}-bin.zip && \
    unzip geoserver.zip -d / && \
    mv /geoserver-${GS_VERSION} /geoserver && \
    chgrp -R 0 /geoserver && \
    chmod -R g+rwX /geoserver && \
    cd /geoserver/webapps/geoserver/WEB-INF/lib && \
    rm jai_core-*jar jai_imageio-*.jar jai_codec-*.jar) && \
    rm -r /tmp/*

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh 
EXPOSE 8080
