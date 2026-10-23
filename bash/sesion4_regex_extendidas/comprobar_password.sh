#!/bin/bash

# Escribe comprobar_password.sh, que recibe una contraseña como parámetro y comprueba si cumple la política de contraseñas del centro:
# Tiene al menos 12 caracteres.
# Contiene algún dígito.Contiene alguna letra mayúscula.
# Contiene algún símbolo, es decir, algún carácter que no sea una letra ni un dígito.
# No es una palabra del diccionario /usr/share/dict/spanish, sin distinguir mayúsculas deminúsculas.Si no recibe ningún parámetro, muestra un mensaje de uso y termina.
# Las condiciones 1 a 4 se comprueban con una expresión regular cada una. 
# La condición 5, congrep.El script muestra el resultado de todas las condiciones, no solo de la primera que falle, y al finalindica si la contraseña es segura.
# Si la contraseña contiene símbolos, hay que escribirla entre comillas simples al ejecutar el script. Si no, la shell puede interpretar algunos de ellos.

if [[ $# -eq 0 ]]; then
    echo "Uso: $0 'contraseña'"
    exit 1
fi

password=$1
diccionario=/usr/share/dict/spanish

re_longitud='.{12,}'
re_digito='[0-9]'
re_mayuscula='[A-Z]'
re_simbolo='[^a-zA-Z0-9]'

cumple=0

if [[ $password =~ $re_longitud ]]; then
    echo " Tiene al menos 12 caracteres: sí"
    ((cumple++))
else
    echo " Tiene al menos 12 caracteres: no"
fi

if [[ $password =~ $re_digito ]]; then
    echo " Contiene algún dígito: sí"
    ((cumple++))
else
    echo " Contiene algún dígito: no"
fi

if [[ $password =~ $re_mayuscula ]]; then
    echo " Contiene alguna mayúscula: sí"
    ((cumple++))
else
    echo " Contiene alguna mayúscula: no"
fi

if [[ $password =~ $re_simbolo ]]; then
    echo " Contiene algún símbolo: sí"
    ((cumple++))
else
    echo " Contiene algún símbolo: no"
fi

if grep -qix "$password" "$diccionario"; then
    echo " No es una palabra del diccionario: no"
else
    echo " No es una palabra del diccionario: sí"
    ((cumple++))
fi

if [[ $cumple -eq 5 ]]; then
    echo "La contraseña es segura"
else
    echo "La contraseña no es segura"
fi

# Pregunta: Caminas2026! cumple todas las condiciones. ¿Te parece realmente una contraseña segura? No me parece
# muy segura. ¿Por qué? Es una palabra normal con el año y un símbolo al final, y eso es lo primero que probaría 
# alguien para adivinarla. Además es el nombre del centro.