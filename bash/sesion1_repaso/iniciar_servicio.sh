#!/bin/bash

#Ejercicio A1. iniciar_servicio.sh
#Escribe un script iniciar_servicio.sh que reciba el nombre de un servicio como argumento (parámetro
#posicional, no con read) y muestre "Iniciando el servicio <nombre>...". Si se ejecuta sin ningún argumento,
#debe mostrar "Debes indicar el nombre del servicio" en su lugar.
#Lista de verificación:
#• ./iniciar_servicio.sh apache2 → Iniciando el servicio apache2...
#• ./iniciar_servicio.sh (sin argumento) → Debes indicar el nombre del servicio
#• El script no usa read en ningún momento; el nombre llega como $1.

if [[ -z "$1" ]];then
	echo "Debes indicar el nombre del servicio"
	exit 1
fi
echo "Iniciando el servicio $1..."
