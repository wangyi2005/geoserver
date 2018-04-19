FROM alpine:3.7

#---------------openjdk JRE8-----------------------------------------------
ENV LANG C.UTF-8
ENV JAVA_VERSION 8u151
ENV JAVA_ALPINE_VERSION 8.151.12-r0
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk/jre
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

ENV JAVA_VERSION 8u151
ENV JAVA_ALPINE_VERSION 8.151.12-r0

RUN apk add --no-cache openjdk8-jre="$JAVA_ALPINE_VERSION"

#RUN apk add --no-cache curl openjdk8-jre="$JAVA_ALPINE_VERSION" && \
#    cd /tmp && \
#    curl -L http://download.java.net/media/jai/builds/release/1_1_3/jai-1_1_3-lib-linux-amd64.tar.gz | tar xfz - && \
#    curl -L http://download.java.net/media/jai-imageio/builds/release/1.1/jai_imageio-1_1-lib-linux-amd64.tar.gz  | tar xfz - && \
#    mv /tmp/jai*/lib/*.jar $JAVA_HOME/jre/lib/ext/ && \
#    mv /tmp/jai*/lib/*.so $JAVA_HOME/jre/lib/amd64/ && \
#    rm -r /tmp/*
   

#-------------------------Geoserver 2.13-------------------------------
ENV GS_VERSION 2.13.0
ENV GEOSERVER_HOME /geoserver/geoserver-${GS_VERSION}

RUN mkdir -m 777 /geoserver && \
    cd /geoserver && \
    wget -O geoserver.zip http://downloads.sourceforge.net/project/geoserver/GeoServer/${GS_VERSION}/geoserver-${GS_VERSION}-bin.zip && \
    unzip geoserver.zip && \ 
    rm -rf geoserver.zip && \
    chmod 777 /geoserver/geoserver-${GS_VERSION}/data_dir

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh 
CMD /entrypoint.sh
EXPOSE 8080
