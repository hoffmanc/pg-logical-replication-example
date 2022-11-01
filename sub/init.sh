
#!/bin/bash

set -e

echo "RUNNING CUSTOM init.sh"

psql -v ON_ERROR_STOP=1 --username "postgres" mydb <<-EOSQL
    create subscription t1sub connection 'user=rep
      password=rep
      channel_binding=prefer
      host=pub
      port=5432
      sslcompression=0
      ssl_min_protocol_version=TLSv1.2
      gssencmode=prefer
      krbsrvname=postgres
      target_session_attrs=any
      sslmode=require
      sslrootcert=/ssl/ca.crt
      sslcert=/ssl/client.crt
      sslkey=/ssl/client.key
      dbname=mydb'
    publication t1pub;
EOSQL
