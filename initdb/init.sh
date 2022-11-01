#!/bin/bash

set -e

echo "RUNNING CUSTOM init.sh"

psql -v ON_ERROR_STOP=1 --username "postgres" <<-EOSQL
    CREATE USER rep REPLICATION PASSWORD 'rep';

    create database mydb;
    \c mydb

    CREATE TABLE t1 (
      id int primary key not null,
      a text
    );
EOSQL
