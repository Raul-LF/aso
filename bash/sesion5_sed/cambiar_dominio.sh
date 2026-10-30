#!/bin/bash

# Escribe cambiar_dominio.sh, que recibe el fichero como parámetro y muestra los correos con el
# dominio @gmail.com o @hotmail.com cambiado por @alu.edu.gva.es. Usa un solo sed.

if [[ $# -eq 0 ]]; then
    echo "Uso: $0 <fichero>"
    exit 1
fi

fichero=$1

if [[ ! -f $fichero ]]; then
    echo "Error: el fichero $fichero no existe"
    exit 1
fi

sed -E 's/@(gmail|hotmail)\.com$/@alu.edu.gva.es/' "$fichero"