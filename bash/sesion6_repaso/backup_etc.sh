#!/bin/bash

# Escribe backup_etc.sh, que hace una copia comprimida del directorio /etc.
# Acepta dos parámetros opcionales: el directorio de destino de las copias (por defecto, /var/backups) y el número máximo de copias recomendado (por defecto, 7).
# Comprueba que el directorio de destino existe. Del número máximo de copias, comprueba con
# una expresión regular que es un número y, después, con una comparación numérica, que es mayor que 0.
# Genera un fichero tar.gz con el nombre etc-AAAAMMDD-HHMMSS.tar.gz, con la fecha y la hora actuales.
# Después, cuenta cuántas copias hay en el directorio de destino. Solo cuentan los ficheros cuyo
# nombre cumple el formato anterior, comprobado con una expresión regular. Si hay más copias que el máximo recomendado, muestra un aviso.
# Cada acción (copia creada, aviso, error) se registra en el sistema con logger, con la etiqueta asobackup,
# y se muestra también por pantalla. Para ello, crea una función registrar que reciba el mensaje y haga las dos cosas.

registrar() {
    echo "$(date +%H:%M:%S) $1"
    logger -t aso-backup "$1"
}

destino=${1:-/var/backups}
maximo=${2:-7}
re='^[0-9]+$'

if [[ ! -d $destino ]]; then
    echo "Error: el directorio $destino no existe"
    exit 1
fi

if [[ ! $maximo =~ $re ]]; then
    echo "Error: $maximo no es un número"
    exit 1
fi

if [[ $maximo -le 0 ]]; then
    echo "Error: el número máximo de copias debe ser mayor que 0"
    exit 1
fi

nombre=etc-$(date +%Y%m%d-%H%M%S).tar.gz

if tar czf "$destino/$nombre" /etc; then
    registrar "Copia creada: $destino/$nombre"
else
    registrar "Error: no se ha podido crear la copia $destino/$nombre"
    exit 1
fi

re_copia='^etc-[0-9]{8}-[0-9]{6}\.tar\.gz$'
contador=0

for fichero in "$destino"/*; do
    base=$(basename "$fichero")
    if [[ $base =~ $re_copia ]]; then
        ((contador++))
    fi
done

if [[ $contador -gt $maximo ]]; then
    registrar "Aviso: hay $contador copias y el máximo recomendado es $maximo"
fi