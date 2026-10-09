#!/bin/bash

# Escribe una función contar_por_extension que reciba una carpeta y una extensión (por ejemplo, log o txt), y
# devuelva (con echo) cuántos ficheros de esa extensión contiene. Con un bucle, aplica la función a
# ~/prueba_bash/datos para las extensiones log, txt y csv, y muestra el resultado de cada una.

contar_por_extension() { 
    local carpeta=$1 
    local ext=$2 

    find "$carpeta" -maxdepth 1 -type f -name "\*.$ext" | wc -l 
} 

directorio="$HOME\prueba_bash\datos"

for ext in log txt csv; do 
    echo "$ext: $(contar_por_extension "$directorio" "$ext")" 
done