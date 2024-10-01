#!/bin/bash

TAPCLI="/usr/local/bin/tapcli --tlscertpath ~/.lit/tls.cert --rpcserver=localhost:8443 --network=mainnet"

# Función para ejecutar un comando tapcli y mostrar la salida
run_tapcli_command() {
    echo "Ejecutando: $1"
    output=$(echo "$1" | bash -c "$(cat)")
    echo "$output"
    echo
}

# Verificar si el archivo coins.json existe
if [ ! -f "coins.json" ]; then
    echo "Error: El archivo coins.json no existe en el directorio actual."
    exit 1
fi

# Mintear cada moneda
jq -c '.[]' coins.json | while read -r coin; do
    name=$(echo $coin | jq -r '.name')
    type=$(echo $coin | jq -r '.type')
    supply=$(echo $coin | jq -r '.supply')
    decimal_display=$(echo $coin | jq -r '.decimal_display')
    issuer=$(echo $coin | jq -r '.meta_bytes.issuer')
    category=$(echo $coin | jq -r '.meta_bytes.category')
    description=$(echo $coin | jq -r '.meta_bytes.description')
    country=$(echo $coin | jq -r '.meta_bytes.country')

    echo "Minteando $name..."
    command="$TAPCLI assets mint --type $type --name \"$name\" --supply $supply --decimal_display $decimal_display --meta_bytes '{\"issuer\":\"$issuer\",\"category\":\"$category\",\"description\":\"$description\",\"country\":\"$country\"}' --meta_type json --new_grouped_asset"
    run_tapcli_command "$command"
done

# Finalizar el minteo
echo "Finalizando el proceso de minteo..."
finalize_command="$TAPCLI assets mint finalize"
run_tapcli_command "$finalize_command"

echo "Proceso de minteo completado."
