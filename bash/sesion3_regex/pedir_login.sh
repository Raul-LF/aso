#!/bin/bash

# Escribe pedir_login.sh, que pide un nombre de usuario con read y lo vuelve a pedir hasta que sea
# válido. Un login es válido si:
# Empieza por una letra minúscula.
# Después solo tiene letras minúsculas o dígitos.
# Cuando sea válido, comprueba si ya existe en el sistema. Si no existe, muestra la orden para crearlo (sin ejecutarla).

re='^[a-z][a-z0-9]*$'

read -p "Nombre de usuario: " login

while [[ ! $login =~ $re ]]; do
    echo " No es válido. Debe empezar por minúscula y tener solo minúsculas o dígitos."
    read -p "Nombre de usuario: " login
done

if grep -q "^$login:" /etc/passwd; then
    echo "El usuario $login ya existe."
else
    echo "Para crearlo: sudo useradd -m -s /bin/bash $login"
fi