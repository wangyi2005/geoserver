FROM anapsix/alpine-java:8u172b11_server-jre_unlimited
#FROM openjdk:8-jre-alpine

# Install Java JAI libraries
RUN \
    apk add --no-cache ca-certificates curl && \
    cd /tmp && \
    curl -L http://download.java.net/media/jai/builds/release/1_1_3/jai-1_1_3-lib-linux-amd64.tar.gz | tar xfz - && \
    curl -L http://download.java.net/media/jai-imageio/builds/release/1.1/jai_imageio-1_1-lib-linux-amd64.tar.gz  | tar xfz - && \
    mv /tmp/jai*/lib/*.jar $JAVA_HOME/jre/lib/ext/  && \
    mv /tmp/jai*/lib/*.so $JAVA_HOME/jre/lib/amd64/  && \
    rm -r /tmp/*
    
# Install tomcat
ENV TOMCAT_MAJOR=8 \
    TOMCAT_VERSION=8.5.30 \
    TOMCAT_HOME=/opt/tomcat \
    CATALINA_HOME=/opt/tomcat \
    CATALINA_OUT=/dev/null

RUN apk upgrade --update && \
    apk add --update curl && \
    curl -jksSL -o /tmp/apache-tomcat.tar.gz http://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    gunzip /tmp/apache-tomcat.tar.gz && \
    tar -C /opt -xf /tmp/apache-tomcat.tar && \
    ln -s /opt/apache-tomcat-${TOMCAT_VERSION} ${TOMCAT_HOME} && \
    rm -rf ${TOMCAT_HOME}/webapps/* && \
    rm -rf /tmp/* /var/cache/apk/*

COPY logging.properties ${TOMCAT_HOME}/conf/logging.properties
COPY server.xml ${TOMCAT_HOME}/conf/server.xml

# Install geoserver
WORKDIR $CATALINA_HOME
ENV GS_VERSION 2.13.0
ENV GEOSERVER_HOME /geoserver
RUN \
    curl -L http://downloads.sourceforge.net/project/geoserver/GeoServer/${GS_VERSION}/geoserver-${GS_VERSION}-war.zip > /tmp/geoserver.zip && \
    unzip /tmp/geoserver.zip -d /tmp && \
    unzip /tmp/geoserver.war -d $CATALINA_HOME/webapps/geoserver && \
    chgrp -R 0 $CATALINA_HOME && \
    chmod -R g+rwX $CATALINA_HOME && \
    cd $CATALINA_HOME/webapps/geoserver/WEB-INF/lib  && \
    rm jai_core-*jar jai_imageio-*.jar jai_codec-*.jar  && \
    apk del curl  && \
    rm -r /tmp/* && \
    rm -rf $CATALINA_HOME/webapps/ROOT && \
    rm -rf $CATALINA_HOME/webapps/docs && \
    rm -rf $CATALINA_HOME/webapps/examples && \
    rm -rf $CATALINA_HOME/webapps/host-manager && \
    rm -rf $CATALINA_HOME/webapps/manager
    
EXPOSE 8080
