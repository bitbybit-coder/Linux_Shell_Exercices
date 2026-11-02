#!/bin/bash

if  file "$1" | grep -q "binary"; then
        echo "Arquivo binário, encerrando programa..."
        exit 1 #encerra o program
else
        echo "Arquivo não binário, continuando programa..."
        if iconv -f  UTF-8 -t UNICODE "$1" > novoarquivo.txt; then
                echo "conversão bem sucedida..."
        else
                echo "Erro na conversão..."
                exit 1
        fi

        echo  "Deseja remover o arquivo antigo? (s/n)"
        read op
        if [ "$op" = "s" ]; then
                if rm "$1"; then
                        echo "Remoção bem sucedida..."
                fi
        fi
fi
