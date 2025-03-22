# Koristi zvaničnu Alpine sliku sa najnovijom verzijom Icecast
FROM alpine:latest

# Instaliraj potrebne pakete za Icecast
RUN apk add --no-cache \
    icecast \
    bash \
    curl \
    libxml2 \
    libxslt \
    shadow  # Instaliraj shadow paket za kreiranje korisnika i grupa

# Kreiraj grupu i korisnika za Icecast (bez root privilegija)
RUN addgroup -S icecast && adduser -S icecast -G icecast

# Kopiraj tvoj config fajl u odgovarajući direktorijum
COPY icecast.xml /etc/icecast/

# Napraviti direktorijum za logove i web root
RUN mkdir -p /var/log/icecast /var/www/icecast

# Kopiraj sve potrebne fajlove (webroot, log dir, itd.) u odgovarajuće direktorijume
COPY ./web /var/www/icecast
COPY ./log /var/log/icecast

# Postavite vlasnika fajlova na korisnika 'icecast'
RUN chown -R icecast:icecast /etc/icecast /var/log/icecast /var/www/icecast

# Izlaganje porta koji Icecast koristi (npr. 8000)
EXPOSE 8000

# Postavite korisnika koji će pokrenuti Icecast
USER icecast

# Komanda koja pokreće Icecast server
CMD ["icecast", "-c", "/etc/icecast/icecast.xml"]
