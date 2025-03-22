FROM alpine:latest

# Instaliraj potrebne pakete
RUN apk add --no-cache \
    icecast \
    bash \
    curl \
    libxml2 \
    libxslt \
    shadow  # Paket koji sadrži addgroup i adduser komande

# Kreiraj simbolički link za sh u /bin (ako nije već tamo)
RUN ln -s /bin/sh /usr/bin/sh

# Kreiraj grupu i korisnika
RUN addgroup -S icecast && adduser -S icecast -G icecast

# Kopiraj config fajl u odgovarajući direktorijum
COPY icecast.xml /etc/icecast/

# Napraviti direktorijum za logove i web root
RUN mkdir -p /var/log/icecast /var/www/icecast

# Kopiraj potrebne fajlove u odgovarajuće direktorijume
COPY ./web /var/www/icecast
COPY ./log /var/log/icecast

# Promeni vlasništvo fajlova na icecast korisnika i grupu
RUN chown -R icecast:icecast /etc/icecast /var/log/icecast /var/www/icecast

# Izlaganje porta koji Icecast koristi
EXPOSE 8000

# Pokreni Icecast sa nižim privilegijama
USER icecast

# Komanda koja pokreće Icecast server
CMD ["icecast", "-c", "/etc/icecast/icecast.xml"]
