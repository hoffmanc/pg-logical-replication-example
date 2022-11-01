# Purpose

Demonstrates logical replication over SSL.

# To Run:

1. `./gen_postgres_certs.sh`
1. `docker-compose up pub`
1. `docker-compose up sub` _after_ pub is up
1. witness replication starting and finishing
1. `echo 'select * from t1' | docker-compose exec -Tu postgres sub psql mydb`
1. verify that rows exist:

```
 id | a
----+---
  1 | a
  2 | b
(2 rows)
```
