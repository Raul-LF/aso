#!/bin/bash

# Escribe puerto.sh, que recibe un número de puerto como parámetro y dice si es válido.
# Si no recibe ningún parámetro, muestra un mensaje de uso y termina.
# Comprueba con una expresión regular que el parámetro solo tiene dígitos.
# Si son dígitos, comprueba que el número está entre 1 y 65535.

if [[ $# -eq 0 ]]; then
    echo "Falta el puerto"
    exit 1
fi

re='^[0-9][0-9]*$'

if [[ ! $1 =~ $re ]]; then
    echo "$1 no es un número"
elif [[ $1 -lt 1 || $1 -gt 65535 ]]; then
    echo "$1 está fuera de rango (1-65535)"
else
    echo "$1 es un puerto válido"
fi
