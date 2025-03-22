# Koristi zvaničnu Alpine sliku sa najnovijom verzijom Icecast
FROM alpine:latest

# Instaliraj potrebne pakete za Icecast
RUN apk add --no-cache \
    icecast \
    bash \
    curl \
    libxml2 \
    libxslt

# Kopiraj tvoj config fajl u odgovarajući direktorijum
COPY icecast.xml /etc/icecast/

# Napraviti direktorijum za logove i web root
RUN mkdir -p /var/log/icecast /var/www/icecast

# Kopiraj sve potrebne fajlove (webroot, log dir, itd.) u odgovarajuće direktorijume
COPY ./web /var/www/icecast
COPY ./log /var/log/icecast

# Izlaganje porta koji Icecast koristi (npr. 8000)
EXPOSE 8000

# Komanda koja pokreće Icecast server
CMD ["icecast", "-c", "/etc/icecast/icecast.xml"]
