#!/bin/bash

TABLESPACE_DIR = '/var/lib/postgresql/tablespaces/osm'
DB_NAME = 'osm_illinois'
TS_NAME = 'osm_tablespace'
DB_USER = 'kvsea'

# CREATE TABLESPACE DIR
sudo mkdir -p "$TABLESPACE_DIR"
sudo chown postgres:postgres "$TABLESPACE_DIR"

# CREATE TABLESPACE AND DATABASE 
sudo -u postgres psql <<EOF
CREATE TABLESPACE $TS_NAME LOCATION '$TABLESPACE_DIR';
CREATE DATABASE $DB_NAME TABLESPACE $TS_NAME OWNER $DB_USER;
\c $DB_NAME
CREATE EXTENSION postgis;
EOF
