# geoserver

 ENV GEOSERVER_DATA_DIR="/geo_data"
 
 oc volume dc/geoserver --add --claim-size 1Gi --mount-path /geoserver/data --name geo-data
 
 oc rsync e:\data  geoserver-xxxxxx:/geo_data
