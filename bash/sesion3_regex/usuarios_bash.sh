#!/bin/bash

# Escribe usuarios_bash.sh, que lee /etc/passwd línea a línea y muestra el nombre de los usuarios
# cuya línea termina en bash. Al final, muestra cuántos hay.

re='bash$'
total=0

while read -r linea; do
    if [[ $linea =~ $re ]]; then
        echo "${linea%%:*}"
        ((total++))
    fi
done < /etc/passwd

echo "----"
echo "Usuarios con bash: $total"