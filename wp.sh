#!/bin/bash -e
clear
echo "============================================"
echo "Instalar Wordpress Brasil"
echo "============================================"
echo "Nome do BD: "
read -e dbname
echo "Nome do Usuario: "
read -e dbuser
echo "Senha do BD: "
read -s dbpass
echo "instalar? (y/n)"
read -e run
if [ "$run" == n ] ; then
exit
else
echo "============================================"
echo "Um robô está instalando o WP para você."
echo "============================================"
#download wordpress
curl -O https://br.wordpress.org/wordpress-4.0-pt_BR.tar.gz
#unzip wordpress
tar -zxvf latest.tar.gz
#entra na pasta
cd wordpress
#copia arquivos no nivel superior
cp -rf . ..
#volta para o nivel superior
cd ..
#remove arquivos desnecessarios
rm -R wordpress
#criar wp config
cp wp-config-sample.php wp-config.php
#set database details with perl find and replace
perl -pi -e "s/database_name_here/$dbname/g" wp-config.php
perl -pi -e "s/username_here/$dbuser/g" wp-config.php
perl -pi -e "s/password_here/$dbpass/g" wp-config.php
#create uploads folder and set permissions
mkdir wp-content/uploads
chmod 777 wp-content/uploads
#remover arquivos de instalação
rm wordpress-4.0-pt_BR.tar.gz
#remover instalador
rm wp.sh
echo "========================="
echo "Instalação completa."
echo "========================="
fi
