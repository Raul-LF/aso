#!/bin/bash

# Escribe tipo_ip.sh, que recibe una dirección IP como parámetro e indica de qué tipo es:
# Loopback: empieza por 127.
# Privada: empieza por 10., por 192.168. o por 172. seguido de un número del 16 al 31.
# Pública: cualquier otra.
# La comprobación de si es privada se hace con una sola expresión regular.

if [[ $# -eq 0 ]]; then
    echo "Uso: $0 <dirección IP>"
    exit 1
fi

ip=$1
formato='^([0-9]{1,3}\.){3}[0-9]{1,3}$'

if [[ ! $ip =~ $formato ]]; then
    echo "$ip no tiene formato de IP"
    exit 1
fi

loopback='^(127){1}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$'

if [[ $ip =~ $loopback ]]; then
    echo "$ip es una dirección loopback"
    exit 0
fi

privada='^(10\.|192\.168\.|172\.(1[6-9]|2[0-9]|3[0-1])\.)'

if [[ $ip =~ $privada ]]; then
    echo "$ip es una dirección privada"
else
    echo "$ip es una dirección pública"
fi

# Pregunta: el rango de 172.16 a 172.31 no se puede escribir con una sola clase. ¿Cómo lo has resuelto?
# Lo he resuelto usando una alternancia a|b dentro de un grupo ().