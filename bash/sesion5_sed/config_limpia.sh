#!/bin/bash

# Escribe config_limpia.sh, que recibe un fichero de configuración y lo muestra sin comentarios ni
# líneas vacías, usando un solo sed.
# Si no recibe ningún parámetro, muestra un mensaje de uso y termina.
# Si el fichero no existe, muestra un error y termina.


if [[ $# -eq 0 ]]; then
    echo "Uso: $0 <fichero>"
    exit 1
fi

fichero=$1

if [[ ! -f $fichero ]]; then
    echo "Error: el fichero $fichero no existe"
    exit 1
fi

sed '/^#/d; /^$/d' "$fichero"