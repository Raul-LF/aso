#!/bin/bash

#Ejercicio A2. nivel_disco.sh
#Escribe un script nivel_disco.sh que reciba dos argumentos: los bytes usados y los bytes totales de un disco. El
#script debe calcular el porcentaje de uso y mostrar un mensaje según el nivel: por debajo de 70 → OK; entre 70
#y 89 (ambos incluidos) → AVISO; 90 o más → CRÍTICO.
#Lista de verificación:
#• ./nivel_disco.sh 35 100 → OK
#• ./nivel_disco.sh 70 100 → AVISO (cuidado con el límite exacto)
#• ./nivel_disco.sh 190 200 → CRÍTICO
#• Usa $(( )) para calcular el porcentaje, y elif para encadenar las tres condiciones.

if [[ $# -ne 2 ]]; then
	echo "Debes indicar el espacio usado y el espacio total"
	exit 1
fi

usado=$1
total=$2

porcentaje=$(( usado * 100 / total ))

if [[ $porcentaje -lt 70 ]];then
	echo "OK ($porcentaje%)"
elif [[ $porcentaje -ge 70 && $porcentaje -lt 90 ]]; then
	echo "AVISO ($porcentaje%)"
else
	echo "CRÍTICO ($porcentaje%)"
fi

