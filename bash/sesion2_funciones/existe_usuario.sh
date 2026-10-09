#!/bin/bash

# Escribe una función existe_usuario que reciba un nombre de usuario y devuelva (con echo) si existe o no en el
# sistema. Llama a la función con un usuario que exista (por ejemplo, root) y con uno que no.

existe_usuario() { 
    if id "$1" &>/dev/null; then 
        echo "El usuario $1 existe en el sistema." 
    else 
        echo "El usuario $1 no existe." 
    fi 
}

existe_usuario root
existe_usuario noexiste123