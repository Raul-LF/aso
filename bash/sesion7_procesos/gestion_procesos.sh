#!/bin/bash
# gestion_procesos.sh
# Menú para gestionar procesos: listar los de un usuario, buscar por nombre,
# ver los que más CPU consumen, cambiar la prioridad y finalizar procesos.
# Los cambios de prioridad y los procesos finalizados se guardan en
# ~/gestion_procesos.log
# Uso: ./gestion_procesos.sh

# Comprueba que $1 es un número y que existe un proceso con ese PID.
# Devuelve 0 si es válido y 1 si no. No muestra nada por pantalla.

validar_pid() {
    re='^[0-9]+$'
    # Primero comprobamos que es un número
    if [[ ! $1 =~ $re ]]; then
        return 1
    fi
    # Después comprobamos que el proceso existe
    if ! ps -p "$1" &>/dev/null; then
        return 1
    fi
    return 0
}

# Pide un usuario y muestra sus procesos.
listar_usuario() {
    read -p "Dame un nombre de usuario: " usuario
    # Comprobamos que el usuario existe antes de mostrar nada
    if ! id "$usuario" &>/dev/null; then
        echo "Error: el usuario $usuario no existe"
        return
    fi
    ps -u "$usuario" -o pid,stat,%cpu,%mem,cmd
}

# Pide un nombre y muestra PID, usuario, %CPU y comando de los procesos que coinciden.
buscar_proceso() {
    read -p "Dime un nombre de proceso: " proceso
    # Si ps no encuentra ninguno, avisamos y volvemos al menú
    if ! ps -C "$proceso" &>/dev/null; then
        echo "No hay ningún proceso que coincida con $proceso"
        return
    fi
    ps -C "$proceso" -o pid,user,%cpu,cmd
}

# Muestra los N procesos que más CPU consumen. $1 = N (por defecto 5).
top_cpu() {
    n=${1:-5}
    re='^[0-9]+$'
    # N tiene que ser un número
    if [[ ! $n =~ $re ]]; then
        echo "Error: $n no es un número"
        return
    fi
    # Ordenamos de mayor a menor CPU; sumamos 1 a N por la línea de cabecera
    ps -eo pid,user,%cpu,comm --sort=-%cpu | head -n $((n + 1))
}

# Pide un PID y un valor nice y cambia la prioridad con renice.
# Root puede usar de -20 a 19; el resto de usuarios, de 0 a 19.
# El cambio se guarda en el log.
cambiar_prioridad() {
    read -p "PID: " pid
    read -p "Nuevo valor nice: " valor

    # El PID tiene que ser válido
    if ! validar_pid "$pid"; then
        echo "Error: el PID $pid no es válido"
        return
    fi

    # El valor tiene que ser un número entero (puede llevar el signo -)
    re_valor='^-?[0-9]+$'
    if [[ ! $valor =~ $re_valor ]]; then
        echo "Error: el valor $valor no es un número entero"
        return
    fi

    # El mínimo depende de si somos root o no
    if [[ $EUID -eq 0 ]]; then
        minimo=-20
    else
        minimo=0
    fi

    # Comprobamos que el valor está dentro del rango permitido
    if [[ $valor -lt $minimo || $valor -gt 19 ]]; then
        echo "Error: el valor debe estar entre $minimo y 19"
        return
    fi

    # Aplicamos el cambio; si funciona, lo apuntamos en el log
    if renice -n "$valor" -p "$pid" &>/dev/null; then
        echo "Prioridad del proceso $pid cambiada a $valor"
        echo "$(date '+%Y-%m-%d %H:%M:%S') - renice $valor - $pid - $(ps -p "$pid" -o comm=)" >> ~/gestion_procesos.log
    else
        echo "Error: no se ha podido cambiar la prioridad del proceso $pid"
    fi
}

# Pide un PID y una confirmación. Envía SIGTERM y, si a los 3 segundos
# el proceso sigue vivo, envía SIGKILL. El resultado se guarda en el log.
finalizar_proceso() {
    read -p "PID: " pid

    # El PID tiene que ser válido
    if ! validar_pid "$pid"; then
        echo "Error: el PID $pid no es válido"
        return
    fi

    # Guardamos el nombre ahora, porque cuando muera el proceso ya no se podrá consultar
    comando=$(ps -p "$pid" -o comm=)

    # Pedimos confirmación
    read -p "¿Finalizar $pid ($comando)? (s/n): " respuesta
    if [[ $respuesta != "s" ]]; then
        echo "Operación cancelada"
        return
    fi

    # Primero SIGTERM, que deja al proceso terminar de forma ordenada
    if ! kill -SIGTERM "$pid" 2>/dev/null; then
        echo "Error: no se ha podido enviar la señal al proceso $pid"
        return
    fi
    senal=SIGTERM

    # Esperamos 3 segundos y, si sigue vivo, lo forzamos con SIGKILL
    sleep 3
    if ps -p "$pid" &>/dev/null; then
        kill -SIGKILL "$pid"
        senal=SIGKILL
    fi

    echo "Proceso $pid finalizado con $senal"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $senal - $pid - $comando" >> ~/gestion_procesos.log
}

# Programa principal: muestra el menú y se repite hasta elegir la opción 6
while true; do
    echo "===== GESTIÓN DE PROCESOS ====="
    echo "1) Listar los procesos de un usuario"
    echo "2) Buscar un proceso por nombre"
    echo "3) Mostrar los N procesos que más CPU consumen"
    echo "4) Cambiar la prioridad de un proceso"
    echo "5) Finalizar un proceso"
    echo "6) Salir"
    read -p "Opción: " opcion

    # Según la opción elegida llamamos a la función que toca
    case $opcion in
        1) listar_usuario ;;
        2) buscar_proceso ;;
        3)
            # Preguntamos cuántos procesos; si no se escribe nada, top_cpu usa 5
            read -p "¿Cuántos procesos quieres ver? (por defecto 5): " cuantos
            top_cpu "$cuantos"
            ;;
        4) cambiar_prioridad ;;
        5) finalizar_proceso ;;
        6) break ;;
        *) echo "Opción no válida" ;;
    esac
done