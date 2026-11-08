#!/bin/bash

# Escribe gestion_usuarios.sh, que prepara el alta o la baja de un usuario del alumnado. El script no crea ni elimina usuarios: muestra la orden que habría que ejecutar.
# Recibe como primer parámetro la acción: alta o baja.
# Alta:
# Pide por teclado el nombre y los dos apellidos. Se puede suponer que se escriben sin tildes.
# Comprueba con expresiones regulares que el nombre es una sola palabra formada por letras y que los apellidos son dos palabras separadas por un espacio. Si no es así, 
# muestra un error y termina.
# Genera el identificador con el formato aluXXYYZ: alu, las dos primeras letras del nombre, las dos primeras del primer apellido y la primera del segundo apellido, todo en minúsculas.
# Si el usuario ya existe, muestra un error. Si no, muestra la orden useradd para crearlo.
# Baja:
# Recibe el identificador como segundo parámetro.
# Comprueba con una expresión regular que tiene el formato aluXXYYZ y que el usuario existe.
# Muestra la orden userdel para eliminarlo.
# Controla los errores: falta la acción, la acción no es válida o falta el identificador.
# Organiza el script en funciones: al menos una para generar el identificador y otra para mostrar los errores.

mostrar_error() {
    echo "Error: $1"
    echo "Uso: $0 alta | baja identificador"
    exit 1
}

generar_id() {
    n=$(echo "$1" | cut -c1-2)
    a1=$(echo "$2" | cut -c1-2)
    a2=$(echo "$3" | cut -c1)
    echo "alu$n$a1$a2" | tr 'A-Z' 'a-z'
}

if [[ $# -eq 0 ]]; then
    mostrar_error "falta la acción"
fi

accion=$1

case $accion in
    alta)
        read -p "Nombre: " nombre
        read -p "Apellidos: " apellidos

        re_nombre='^[A-Za-z]+$'
        re_apellidos='^[A-Za-z]+ [A-Za-z]+$'

        if [[ ! $nombre =~ $re_nombre ]]; then
            mostrar_error "el nombre debe ser una sola palabra formada por letras"
        fi

        if [[ ! $apellidos =~ $re_apellidos ]]; then
            mostrar_error "escribe los dos apellidos separados por un espacio"
        fi

        apellido1=$(echo "$apellidos" | cut -d' ' -f1)
        apellido2=$(echo "$apellidos" | cut -d' ' -f2)

        usuario=$(generar_id "$nombre" "$apellido1" "$apellido2")
        echo "Identificador generado: $usuario"

        if id "$usuario" &>/dev/null; then
            mostrar_error "el usuario $usuario ya existe"
        fi

        echo "Para crearlo: sudo useradd -m -s /bin/bash -c \"$nombre $apellidos\" $usuario"
        ;;
    baja)
        if [[ $# -lt 2 ]]; then
            mostrar_error "falta el identificador"
        fi

        usuario=$2
        re_id='^alu[a-z]{5}$'

        if [[ ! $usuario =~ $re_id ]]; then
            mostrar_error "$usuario no tiene el formato aluXXYYZ"
        fi

        if ! id "$usuario" &>/dev/null; then
            mostrar_error "el usuario $usuario no existe"
        fi

        echo "Para eliminarlo: sudo userdel -r $usuario"
        ;;
    *)
        mostrar_error "la acción $accion no es válida"
        ;;
esac