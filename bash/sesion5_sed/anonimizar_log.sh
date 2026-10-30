#!/bin/bash

# Escribe anonimizar_log.sh, que recibe un fichero de registro y genera una copia con el mismo
# nombre terminado en .anonimo, en la que todas las direcciones IP se han sustituido por X.X.X.X. El
# fichero original no se modifica.

if [[ $# -eq 0 ]]; then
    echo "Uso: $0 <fichero>"
    exit 1
fi

fichero=$1

if [[ ! -f $fichero ]]; then
    echo "Error: el fichero $fichero no existe"
    exit 1
fi

sed -E 's/([0-9]{1,3}\.){3}[0-9]{1,3}/X.X.X.X/g' "$fichero" > "$fichero.anonimo"