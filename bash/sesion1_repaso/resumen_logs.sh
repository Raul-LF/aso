#!/bin/bash

#Ejercicio C1. resumen_logs.sh
#Imagina que eres administrador/a de sistemas y te piden un primer script de monitorización rápida. Escribe un
#script resumen_logs.sh que reciba como argumento el nombre de una carpeta, y para cada fichero .log que
#encuentre dentro, muestre su nombre junto con cuántas líneas contienen la palabra WARNING y cuántas
#contienen la palabra ERROR.
#Lista de verificación:
#• ./resumen_logs.sh ~/prueba_bash/datos
#• app1.log → 0 WARNING, 2 ERROR
#• app2.log → 1 WARNING, 3 ERROR
#Ampliación (opcional)
#Ejecuta tu resumen_logs.sh pasándole ~/prueba_bash (la carpeta raíz, no datos/). ¿Encuentra sistema.log? ¿Y
#los .log que hay dentro de datos/ y de proyecto/entrada/? Explica, en un comentario al final del script, si tu
#script mira solo dentro de la carpeta indicada o también dentro de sus subcarpetas, y si te parece el
#comportamiento correcto para un script de monitorización real.

carpeta="$HOME/prueba_bash/datos"

for fichero in "$carpeta"/*.log; do
	nombre=$(basename "$fichero")
	errores=$(grep -c "ERROR" "$fichero")
	warning=$(grep -c "WARNING" "$fichero")
	echo "$nombre: $warning WARNING, $errores ERROR"
done

# Ampliación C1:
# Al ejecutar ./resumen_logs.sh ~/prueba_bash, solo encuentra sistema.log
# No encuentra los .log de datos/ ni de proyecto/entrada/,
# porque el * no es recursivo y solo mira el primer nivel de la carpeta.
# Para un script de monitorización real esto no sería suficiente, ya que
# los logs suelen estar repartidos en subcarpetas.
