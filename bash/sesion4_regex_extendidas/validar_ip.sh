#!/bin/bash

# Escribe validar_ip.sh, que recibe una dirección IPv4 como parámetro e indica si tiene el formato
# correcto: cuatro números de 1 a 3 cifras separados por puntos.
# Si no recibe ningún parámetro, muestra un mensaje de uso y termina.
# La comprobación se hace con una sola expresión regular.

if [[ $# -eq 0 ]]; then
    echo "Uso: $0 <dirección IP>"
    exit 1
fi

ip=$1
re='^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$'

if [[ $ip =~ $re ]]; then
    echo "$ip tiene formato de IP"
else
    echo "$ip no tiene formato de IP"
fi

# Pregunta: ¿qué responde tu script con 999.999.999.999? con 999.999.999.999 el script responde que tiene formato de IP.
# ¿Es una IP válida? No es una IP válida, porque cada número tiene que estar entre 0 y 255.