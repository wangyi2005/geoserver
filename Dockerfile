FROM anapsix/alpine-java:8u172b11_server-jre

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

# Install Java JAI libraries
RUN \
    cd /tmp && \
    curl -L http://download.java.net/media/jai/builds/release/1_1_3/jai-1_1_3-lib-linux-amd64.tar.gz | tar xfz - && \
    curl -L http://download.java.net/media/jai-imageio/builds/release/1.1/jai_imageio-1_1-lib-linux-amd64.tar.gz  | tar xfz - && \
    mv /tmp/jai*/lib/*.jar $JAVA_HOME/jre/lib/ext/ && \
    mv /tmp/jai*/lib/*.so $JAVA_HOME/jre/lib/amd64/ && \
    rm -r /tmp/*

# Install geoserver
ENV GS_VERSION 2.13
RUN wget http://downloads.sourceforge.net/project/geoserver/GeoServer/${GS_VERSION}/geoserver-${GS_VERSION}-war.zip -O /tmp/geoserver.zip && \
    unzip /tmp/geoserver.zip && \
    rm -rf ${CATALINA_HOME}/webapps/* && \
    unzip /tmp/geoserver.war -d $CATALINA_HOME/webapps/ROOT && \
    (cd $CATALINA_HOME/webapps/ROOT/WEB-INF/lib; rm jai_core-*jar jai_imageio-*.jar jai_codec-*.jar) && \
    rm -r /tmp/*

# Install plugins (WPS)
RUN curl -L http://ares.boundlessgeo.com/geoserver/${GEOSERVER_VERSION_NAME}/ext-latest/geoserver-${GEOSERVER_VERSION}-SNAPSHOT-wps-plugin.zip > /tmp/geoserver-wps-plugin.zip && \
    unzip /tmp/geoserver-wps-plugin.zip -d $CATALINA_HOME/webapps/ROOT/WEB-INF/lib/ && \
    rm /tmp/*

# Install Marlin
RUN cd /usr/local/tomcat/lib && wget https://github.com/bourgesl/marlin-renderer/releases/download/v0.7.4_2/marlin-0.7.4-Unsafe.jar && \
    wget https://github.com/bourgesl/marlin-renderer/releases/download/v0.7.4_2/marlin-0.7.4-Unsafe-sun-java2d.jar

ENV CATALINA_OPTS "-Xbootclasspath/a:/usr/local/tomcat/lib/marlin-0.7.4-Unsafe.jar -Xbootclasspath/p:/usr/local/tomcat/lib/marlin-0.7.4-Unsafe-sun-java2d.jar -Dsun.java2d.renderer=org.marlin.pisces.PiscesRenderingEngine" 
VOLUME ["/logs"]
EXPOSE 8080
