#!/bin/bash

# Los ficheros de configuración tienen muchas líneas de comentarios (empiezan por #) y líneas vacías.
# Escribe config_activa.sh, que recibe un fichero y muestra solo las líneas útiles.
# Si no recibe parámetro, usa /etc/login.defs.
# Si el fichero no existe, muestra un error y termina.
# Salta las líneas que empiezan por # y las líneas vacías.
# Al final, muestra cuántas líneas tiene el fichero y cuántas son útiles.

fichero="${1:-/etc/login.defs}"

if [[ ! -f $fichero ]]; then
    echo "Error: el fichero $fichero no existe"
    exit 1
fi

re_comentario='^#'
re_vacia='^$'
totales=0
utiles=0

while read -r linea; do
    ((totales++))
    if [[ $linea =~ $re_comentario || $linea =~ $re_vacia ]]; then
        continue
    fi
    echo "$linea"
    ((utiles++))
done < "$fichero"

echo "----"
echo "Líneas totales: $totales"
echo "Líneas útiles: $utiles"

# PASS_MAX_DAYS son los días que dura una contraseña antes de tener que cambiarla. 
# No me parece seguro, según la configuración tiene 99999, una contraseña robada serviría para muchos años.