#!/bin/bash

mkdir -p  ~/becape
tar -cvjpf ~/becape/becape-$(date +%F).tar.bz2 /home/teste/Documentos/

read -p "Deseja criar o log do becape? (s/n)" op
if [ "$op" = "s"  ]; then

        echo "Execução do Becape - $(date +%F)" >> ~/becape/logBKP.txt
        echo "Horário de inicio - $(date +%H:%M:%S)" >> ~/becape/logBKP.txt
        echo "Arquivos compactados: " >> ~/becape/logBKP.txt
        find /home/teste/Documentos/ -type f >>  ~/becape/logBKP.txt

        echo "Diretório de becape: $(realpath ~/becape/)" >> ~/becape/logBKP.txt
        echo "Horário de finalização do becape - $(date +%H:%M:%S)" >> ~/becape/logBKP.txt

else
        echo "Arquivo de log ignorado..."
fi
