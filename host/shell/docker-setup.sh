#!/bin/sh
docker import - zskulcsar/petrol-nginx:latest < /tmp/petrol-nginx.tar
docker run -d -p 80:80 -p 443:443 zskulcsar/petrol-nginx:latest /bin/true