#!/bin/sh
# This is unfortunate here: that the host need to know this lot about the container image
# simple solution would be to use docker repo ...
docker import - -c 'CMD ["nginx", "-g", "pid /tmp/nginx.pid; daemon off;"]' zskulcsar/petrol-nginx:latest < /tmp/petrol-nginx.tar
docker run -d -p 80:80 -p 443:443 zskulcsar/petrol-nginx:latest