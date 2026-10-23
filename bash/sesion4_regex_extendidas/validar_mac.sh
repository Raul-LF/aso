#!/bin/bash

# Escribe validar_mac.sh, que recibe una dirección MAC como parámetro e indica si es válida. Una
# MAC válida tiene seis pares de dígitos hexadecimales (del 0 al 9 y de la a a la f, en mayúsculas o
# minúsculas) separados por : o por -.
# La comprobación se hace con una sola expresión regular.

if [[ $# -eq 0 ]]; then
    echo "Uso: $0 <dirección MAC>"
    exit 1
fi

mac=$1
re='^[0-9A-Fa-f]{2}[:-][0-9A-Fa-f]{2}[:-][0-9A-Fa-f]{2}[:-][0-9A-Fa-f]{2}[:-][0-9A-Fa-f]{2}[:-][0-9A-Fa-f]{2}$'

if [[ $mac =~ $re ]]; then
    echo "$mac es una MAC válida"
else
    echo "$mac no es una MAC válida"
fi