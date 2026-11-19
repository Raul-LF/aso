#!/bin/bash
# backup_rsync.sh - copia una carpeta del servidor con rsync

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
destino=$base/espejo
mkdir -p "$base" "$destino"

if ! ssh -o BatchMode=yes servidor true; then
    echo "Error: el servidor no responde"
    registrar "$carpeta" "ERROR (servidor no responde)"
    exit 1
fi

if rsync -av servidor:"$carpeta"/ "$destino"/; then
    echo "Copia sincronizada en $destino"
    registrar "$carpeta" "OK"
else
    echo "Error: no se ha podido sincronizar $carpeta"
    registrar "$carpeta" "ERROR (fallo al sincronizar)"
    exit 1
fi