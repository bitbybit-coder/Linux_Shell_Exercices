#!/bin/bash

contador=0 

while IFS=: read -r usuario senha uid resto; do

        if [ "$uid" -ge 1000 ]; then
                contador=$((contador + 1))
        fi

done < /etc/passwd

echo "Quantidade de usuários humanos: $contador"
