#!/bin/bash

set -e # exit immediately if a command returns with a non-zero status

echo "Stopping PostgreSQL service..."
sudo systemctl stop postgresql || echo "PostgreSQL service not running or not found."

echo "Purging PostgreSQL packages..."
sudo apt-get --purge remove -y postgresql postgresql-* || echo "PostgreSQL packages not found."

echo "Removing unneccesary packages and cleaning up..."
sudo apt-get autoremove -y
sudo apt-get autoclean

echo "Deleting PostgreSQL data directories and config files..."
sudo rm -rf /var/lib/postgresql/
sudo rm -rf /etc/postgresql/
sudo rm -rf /var/log/postgresql/
sudo rm -rf /etc/postgresql-common/

echo "Removing PostgreSQL user and group..."
sudo deluser --remove-home postgres || echo "User postgres not found."
sudo delgroup postgres || echo "Group postgres not found."

echo "Verifying removal..."
if command -v pqsl >/dev/null 2>&1; then
    echo "Warning: psql command still exists."
else
    echo "psql command removed."

fi

if systemctllist-units --full -all | grep -Fq "postgresql.service"; then
    echo "Warning: PostgreSQL service still exists."
else
    echo "PostgreSQL service removed."

fi 

echo "PostgreSQL removal complete.