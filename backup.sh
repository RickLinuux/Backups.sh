#!/usr/bin/env bash
#
#############################################################################
# backup.sh - Script executa três tipos de backups.                         #
# 									    #
# Autor: Henrique Rocha (hrprocha3@outlook.com)				    #	
# Data: 15/01/24 							    #
#									    #
# Descrição: Script realiza backups, usuário escolhe a opção desejada e     #
#	     O script inicia o backup, mas antes faz um teste lógico para   #
#	     verificar se existe um diretório de destino.                   #
# 									    #
# Versão 0.01: Declarando varivaeis a serem utilizadas			    #
# Versão 0.02: Adicionando suporte -h --help				    #
# Versão 0.03: Adicionando menu de suporte para usuário			    #
# Versão 0.04: Melhoria no código, deixando-o mais limpo		    #
# Versão 0.05: Criando funções para deixar o código mais legível            #
# Versão 0.06: Alteração nas linhas de código, removendo redundância	    #					
#	       de blocos repetitivos					    #
#							 	 	    #
# Uso: ./backup.sh							    #
#############################################################################

echo "Inicializando script de backup."
# Diretórios de backup e destino
diretorio_backup=/home/shaka/Henrique
incremental_backup=/mnt/backups/incremental
complete_backup=/mnt/backups/completo
diferencial_backup=/mnt/backups/diferencial

MENSAGEM_USO="
Uso: $(basename $0) [OPÇÕES]

OPÇÕES:
-h, --help  Mostra esta tela de ajuda e sai
-v, --version  Mostra a versão do programa e sai
-i, --incremental realiza  backup incremental
-c, --complete realiza backup completo 
-d, --diferencial realiza backup diferencial
"

# função de auxilio
# Funções de auxilio
incremental() {
    backup $incremental_backup "rsync -avh --progress --delete $diretorio_backup $incremental_backup"
}

completo() {
    backup $complete_backup "rsync -avh --progress $diretorio_backup $complete_backup"
}

diferencial() {
    backup $diferencial_backup "rsync -avh --link-dest=$diferencial_backup/ultimo --progress $diretorio_backup $diferencial_backup/$(date "+%Y-%m-%d")"
}

backup() {
    local dir_destino=$1
    local comando=$2

    if [ -d "$dir_destino" ]; then
        echo "Diretório de destino encontrado. Iniciando Backup..."
        eval $comando
        echo "Backup Finalizado."
    else 
        echo "Diretório não encontrado. Abortando Backup."
    fi
}

#Tratamento das linhas de comandos
while test -n "$1"
do
case "$1" in
	-h | --help)
		echo "$MENSAGEM_USO"
		exit 0
		;;
	-v | --version)
		#Extrair a versão direto do cabeçalho
		grep '^# Versão' "$0" | tail -1 | cut -d : -f 1| tr -d \#
		exit 0
		;;
	-i | --incremental)
		incremental
		exit 0
		;;
	-c | --complete)
		completo
		exit 0
		;;
	-d | --diferencial)
		diferencial
		exit 0
		;;
	*)
		echo "Opção inválida"
		exit 1
		;;
	esac 
done
