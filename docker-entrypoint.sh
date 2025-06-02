#!/bin/bash
set -e # Beende das Skript sofort, wenn ein Befehl fehlschlägt

# Standardargumente für netcheck.sh
NETCHECK_ARGS=()

# Webserver immer starten (via -w Flag)
# NETCHECK_ENABLE_WEBSERVER steuert dies (standardmäßig 'true')
if [ "${NETCHECK_ENABLE_WEBSERVER:-true}" = "true" ]; then
  NETCHECK_ARGS+=("-w") # Schaltet den Webserver ein
  NETCHECK_ARGS+=("-p") # Legt NUR den Port fest (netcheck.sh erwartet nur die Portnummer hier)
  # Extrahiere die Portnummer aus NETCHECK_WEBSERVER_LISTEN. Standard ist 9000.
  LISTEN_PORT=$(echo "${NETCHECK_WEBSERVER_LISTEN:-0.0.0.0:9000}" | cut -d':' -f2)
  NETCHECK_ARGS+=("${LISTEN_PORT}")
fi

# Logdatei-Pfad (bleibt auskommentiert, damit das Webinterface funktioniert)
#if [ -n "${NETCHECK_LOG_FILE_PATH}" ]; then
#  NETCHECK_ARGS+=("-f")
#  NETCHECK_ARGS+=("${NETCHECK_LOG_FILE_PATH}")
#else
#  # Standard-Logdatei im gemappten Volume
#  NETCHECK_ARGS+=("-f")
#  NETCHECK_ARGS+=("/app/logs/connection.log")
#fi

# Speedtest deaktivieren
# NETCHECK_DISABLE_SPEEDTEST steuert dies (standardmäßig 'false')
if [ "${NETCHECK_DISABLE_SPEEDTEST:-false}" = "true" ]; then
  NETCHECK_ARGS+=("-s") # Deaktiviert den Speedtest
fi

# Speedtest immer ausführen (neu in netcheck.sh)
# NETCHECK_ALWAYS_SPEEDTEST steuert dies (standardmäßig 'false')
if [ "${NETCHECK_ALWAYS_SPEEDTEST:-false}" = "true" ]; then
  NETCHECK_ARGS+=("-e") # Führt Speedtest bei jeder Verbindungsprobe aus
fi

# Führe netcheck.sh mit den gesammelten Argumenten und allen zusätzlichen Argumenten aus,
# die dem Docker-Container beim Start übergeben werden (z.B. -h für Hilfe).
echo "Starte netcheck.sh mit Argumenten: ${NETCHECK_ARGS[*]} $*"
exec ./netcheck.sh "${NETCHECK_ARGS[@]}" "$@"