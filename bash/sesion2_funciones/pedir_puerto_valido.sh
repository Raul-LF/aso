#!/bin/bash

# Escribe una función pedir_puerto_valido que pida repetidamente un puerto TCP (con read -p) hasta que el
# usuario introduzca un número entre 1 y 65535, y entonces termine. Llama a la función y, cuando acabe, muestra
# el puerto recibido.

pedir_puerto_valido() {
    read -p "Introduce un puerto TCP (1 - 65535): " puerto
    while ! [[ $puerto =~ ^[0-9]+$ ]] || ! (( puerto >= 1 && puerto <= 65535 )); do 
    echo "Puerto no válido. Debe ser un número entre 1 y 65535." 
    read -p "Introduce un puerto TCP (1-65535): " puerto 
    done
}

pedir_puerto_valido

echo "Puerto válido recibido: $puerto"