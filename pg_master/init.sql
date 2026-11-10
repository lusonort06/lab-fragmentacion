CREATE EXTENSION IF NOT EXISTS postgres_fdw;

CREATE SERVER servidor_norte
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'pg_nodo_norte', port '5432', dbname 'labdb');

CREATE SERVER servidor_sur
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'pg_nodo_sur', port '5432', dbname 'labdb');

CREATE USER MAPPING FOR labuser SERVER servidor_norte
OPTIONS (user 'labuser', password 'labpass');

CREATE USER MAPPING FOR labuser SERVER servidor_sur
OPTIONS (user 'labuser', password 'labpass');

CREATE FOREIGN TABLE clientes_norte (
  id INTEGER,
  nombre VARCHAR(100),
  region VARCHAR(20),
  saldo NUMERIC(12,2)
)
SERVER servidor_norte
OPTIONS (table_name 'clientes');

CREATE FOREIGN TABLE clientes_sur (
  id INTEGER,
  nombre VARCHAR(100),
  region VARCHAR(20),
  saldo NUMERIC(12,2)
)
SERVER servidor_sur
OPTIONS (table_name 'clientes');

CREATE VIEW clientes_todos AS
SELECT * FROM clientes_norte
UNION ALL
SELECT * FROM clientes_sur;