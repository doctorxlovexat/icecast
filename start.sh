#!/bin/bash

# Postavi potrebnu putanju do tvog icecast.xml fajla
ICECAST_XML_PATH=/path/to/your/icecast.xml

# Pokreće Icecast server sa odgovarajućim XML fajlom
docker run -d -p 8000:8000 --name icecast \
  -v $ICECAST_XML_PATH:/etc/icecast/icecast.xml \
  my-icecast
