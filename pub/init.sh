
#!/bin/bash

set -e

echo "RUNNING CUSTOM init.sh"

psql -v ON_ERROR_STOP=1 --username "postgres" mydb <<-EOSQL
    INSERT INTO t1 (id, a) VALUES (1,'a');
    INSERT INTO t1 (id, a) VALUES (2,'b');

    GRANT SELECT ON ALL TABLES IN SCHEMA public TO rep;
    create publication t1pub for table t1;
EOSQL
