# Verwende ein schlankes Basis-Image mit Bash
FROM alpine:latest

# Setze eine Umgebungsvariable für die Version von speedtest-cli
ARG SPEEDTEST_CLI_VERSION=v2.1.3

# Aktualisiere Pakete und installiere notwendige Dienstprogramme:
# - bash: Wird für die Ausführung des Shell-Skripts und des Entrypoint-Skripts benötigt.
# - curl: Wird für das Herunterladen von speedtest.py und für die Web-Checks benötigt.
# - iputils: Enthält das 'ping'-Kommando.
# - python3: Notwendig, um die heruntergeladene 'speedtest.py' Datei auszuführen.
RUN apk update && \
    apk add --no-cache \
    bash \
    curl \
    iputils \
    python3 \
    tzdata

# Setze das Arbeitsverzeichnis im Container
WORKDIR /app

# Lade die spezifische Version von speedtest.py herunter und benenne sie in speedtest-cli.py um.
# Mache sie anschließend ausführbar.
RUN curl -L "https://raw.githubusercontent.com/sivel/speedtest-cli/${SPEEDTEST_CLI_VERSION}/speedtest.py" -o speedtest-cli.py && \
    chmod +x speedtest-cli.py

# Kopiere das netcheck.sh-Skript in das Arbeitsverzeichnis des Containers
COPY netcheck.sh .

# Mache das netcheck.sh-Skript ausführbar
RUN chmod +x netcheck.sh

# Kopiere die Webserver-Dateien in das Verzeichnis /app/log im Container
# Beachte, dass dein lokaler 'log'-Ordner die Webserver-Dateien enthält
COPY log/index.html /app/log/index.html
COPY log/js /app/log/js
COPY log/fonts /app/log/fonts
COPY log/styles.css /app/log/styles.css

# Kopiere das Entrypoint-Skript und mache es ausführbar
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Lege das Entrypoint-Skript fest, das die Konfiguration über Umgebungsvariablen verarbeitet
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# Es wird keine CMD benötigt, da das Entrypoint-Skript alle Argumente konstruiert
