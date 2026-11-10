#!/bin/bash

# Escribe inventario_cuentas.sh, que muestra las cuentas de /etc/passwd que usan una shell determinada.
# Acepta opcionalmente la shell por parámetro. Si no se indica, se usa /bin/bash.
# Comprueba con una expresión regular que el parámetro es una ruta absoluta: empieza por / y
# está formada por nombres en minúsculas separados por /.
# Muestra por pantalla, para cada cuenta con esa shell, una línea con el formato
# usuario:uid:home:shell.
# Al final, muestra un resumen con el total de cuentas listadas y cuántas tienen un UID mayor o
# igual que 1000.

# Ayuda: while IFS=':' read -r usuario x uid gid desc home shell; do ... done < /etc/passwd

shell_buscada=${1:-/bin/bash}
re='^(/[a-z]+)+$'

if [[ ! $shell_buscada =~ $re ]]; then
    echo "Error: $shell_buscada no es una ruta válida"
    exit 1
fi

total=0
mayor=0

while IFS=':' read -r usuario x uid gid desc home shell; do
    if [[ $shell == "$shell_buscada" ]]; then
       echo "$usuario:$uid:$home:$shell"
       ((total++))
          if [ $uid -ge 1000 ]; then
              ((mayor++))
          fi
    fi
done < /etc/passwd

echo "----"
echo "Cuentas listadas: $total"
echo "Con UID >= 1000: $mayor"