#!/bin/bash

# Escribe tipos_etc.sh, que recorre los ficheros de /etc y cuenta cuántos hay de cada tipo según cómo
# termina su nombre:
# Configuración: terminan en .conf
# Copias de seguridad: terminan en .bak o en ~
# Al final, muestra la lista de ficheros .conf y los dos totales.

re_conf='\.conf$'
re_bak='\.bak$'
re_tilde='~$'

conf=0
bak=0

echo "Ficheros de configuración:"

for fichero in /etc/*; do
    if [[ $fichero =~ $re_conf ]]; then
        echo " $fichero"
        ((conf++))
    elif [[ $fichero =~ $re_bak || $fichero =~ $re_tilde ]]; then
        ((bak++))
    fi
done

echo "----"
echo "Configuración: $conf"
echo "Copias de seguridad: $bak"