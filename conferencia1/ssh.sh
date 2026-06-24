#!/bin/bash

echo "Actualizando repositorios..."
sudo apt update

echo "Instalando OpenSSH Server..."
sudo apt install -y openssh-server

echo "Habilitando servicio SSH..."
sudo systemctl enable ssh

echo "Iniciando servicio SSH..."
sudo systemctl start ssh

echo "Estado del servicio:"
sudo systemctl status ssh --no-pager

echo ""
echo "Dirección IP del equipo:"
hostname -I

echo ""
echo "Instalación completada."
