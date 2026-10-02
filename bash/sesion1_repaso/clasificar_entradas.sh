#!/bin/bash

#Ejercicio B1. clasificar_entradas.sh
#Escribe un script clasificar_entradas.sh que recorra todas las entradas de ~/prueba_bash (no solo la carpeta
#datos) y muestre, para cada una, su nombre seguido de "fichero" o "directorio", según corresponda.
#Pista
#Los tests -f (es fichero) y -d (es directorio) del Bloque A también sirven aquí, dentro del bucle.
#Para quedarte solo con el nombre (sin la ruta completa) prueba basename "$entrada".
#Lista de verificación:
#• El resultado tiene una línea por cada entrada de ~/prueba_bash.
#• datos y proyecto deben aparecer como directorio; plantilla.sh, sistema.log y los scripts que ya tengas
#creados (iniciar_servicio.sh, nivel_disco.sh…) como fichero.
#• El número exacto de líneas puede variar: depende de qué ficheros tengas ya en tu carpeta.

carpeta="$HOME/prueba_bash"

for entrada in "$carpeta"/*; do
	nombre=$(basename "$entrada")
	if [[ -d "$entrada" ]]; then
		echo "$nombre: directorio"
	elif [[ -f "$entrada" ]]; then
		echo "$nombre: fichero"
	fi
done
