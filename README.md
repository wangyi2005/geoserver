# geoserver

 ENV GEOSERVER_DATA_DIR="/geoserver/data"
 
 oc volume dc/geoserver --add --claim-size 1Gi --mount-path /geoserver/data --name geo-data
 
 oc rsync e:\data  geoserver-xxxxxx:/geoserver/data
