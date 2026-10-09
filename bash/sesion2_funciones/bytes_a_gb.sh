#!/bin/bash

# Escribe una función bytes_a_gb que reciba un número de bytes (por ejemplo, el tamaño que devuelve du o df) y
# devuelva (con echo) su equivalente en GB, con 2 decimales de precisión. 1 GB = 1073741824 bytes.

bytes_a_gb() {
    local bytes=$1
    echo "scale=2; $bytes / 1073741824" | bc
}

bytes_a_gb 5000000000
bytes_a_gb 1073741824