#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
  CREATE DATABASE "$POSTGRES_DATABASE";
  \c test_db;
  \i home/setup.sql;
  \i home/fake.sql;