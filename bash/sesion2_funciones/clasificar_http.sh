#!/bin/bash

# Escribe una función clasificar_http que reciba un código de estado HTTP (como los que aparecen en los logs de
# un servidor web) y devuelva (con echo): "Éxito" (200-299), "Redirección" (300-399), "Error del cliente"
# (400-499), "Error del servidor" (500-599). Prueba la función con varios códigos.

clasificar_http() { 
    local codigo=$1 

    if [[ $codigo -ge 200 && $codigo -le 299 ]]; then 
        echo "Éxito" 
    elif [[ $codigo -ge 300 && $codigo -le 399 ]]; then 
        echo "Redirección" 
    elif [[ $codigo -ge 400 && $codigo -le 499 ]]; then 
        echo "Error del cliente" 
    elif [[ $codigo -ge 500 && $codigo -le 599 ]]; then 
        echo "Error del servidor" 
    fi 
} 

clasificar_http 200 
clasificar_http 301 
clasificar_http 404 
clasificar_http 500