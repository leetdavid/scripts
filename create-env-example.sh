#!/bin/bash

set -e

ENV_FILE=".env"
EXAMPLE_FILE=".env.example"

if [ ! -f "$ENV_FILE" ]; then
    echo "Error: $ENV_FILE file not found!"
    exit 1
fi

echo "Creating $EXAMPLE_FILE from $ENV_FILE..."

while IFS= read -r line || [[ -n "$line" ]]; do
    if [[ "$line" =~ ^[[:space:]]*# ]] || [[ -z "${line// }" ]]; then
        echo "$line"
    elif [[ "$line" =~ ^[[:space:]]*([A-Za-z_][A-Za-z0-9_]*)[[:space:]]*=[[:space:]]*(.*)$ ]]; then
        var_name="${BASH_REMATCH[1]}"
        var_value="${BASH_REMATCH[2]}"
        
        if [[ "$var_value" =~ ^[\"\'](.*)[\"\']+$ ]]; then
            quote_char="${var_value:0:1}"
            echo "${var_name}=${quote_char}${quote_char}"
        else
            echo "${var_name}="
        fi
    else
        echo "$line"
    fi
done < "$ENV_FILE" > "$EXAMPLE_FILE"

echo "Successfully created $EXAMPLE_FILE"
echo "Please review the file and add placeholder values or comments as needed."