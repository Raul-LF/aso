#!/bin/bash
# backup_scp.sh - copia una carpeta del servidor con scp

registrar() {
    echo "$(date '+%F %H:%M:%S') - $1 - $2" >> "$log"
}

if [[ $# -ne 1 ]]; then
    echo "Uso: $0 <carpeta_remota>"
    exit 1
fi

carpeta=$1
base=$HOME/backups
log=$base/backup.log
mkdir -p "$base"
nombre=$(basename "$carpeta")
destino=$base/${nombre}_$(date +%F_%H-%M)

if ! ssh -o BatchMode=yes servidor true; then
    echo "Error: el servidor no responde"
    registrar "$carpeta" "ERROR (servidor no responde)"
    exit 1
fi

if scp -r servidor:"$carpeta" "$destino"; then
    echo "Copia creada en $destino"
    registrar "$carpeta" "OK"
else
    echo "Error: no se ha podido copiar $carpeta"
    registrar "$carpeta" "ERROR (fallo al copiar)"
    exit 1
fi