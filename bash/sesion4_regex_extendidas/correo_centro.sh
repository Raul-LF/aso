#!/bin/bash

# Escribe correo_centro.sh, que recibe una dirección de correo como parámetro e indica si es una cuenta educativa de Conselleria y de qué tipo:
# Profesorado: nombre@edu.gva.es
# Alumnado: nombre@alu.edu.gva.es
# El nombre tiene al menos un carácter y solo puede contener letras minúsculas, dígitos, puntos, guiones o guiones bajos.
# Si no recibe ningún parámetro, muestra un mensaje de uso y termina.
# Comprueba con una sola expresión regular que la dirección es de alguno de los dos tipos.
# Si lo es, indica si pertenece a profesorado o a alumnado.

if [[ $# -eq 0 ]]; then
    echo "Uso: $0 <correo>"
    exit 1
fi

correo=$1
re='^[a-z0-9._-]+@(alu\.)?edu\.gva\.es$'
re_alumno='@alu\.'

if [[ $correo =~ $re ]]; then
    if [[ $correo =~ $re_alumno ]]; then
        echo "$correo es una cuenta de alumnado"
    else
        echo "$correo es una cuenta de profesorado"
    fi
else
    echo "$correo no es una cuenta educativa"
fi