#!/bin/bash
set  -ex

function subj {
  echo "/CN=$1/O=LogicalRep/C=US"
}
dir=ssl

mkdir -p $dir
openssl req -subj $(subj ca) -days 3650 -nodes -new -x509 -extensions v3_ca -keyout $dir/ca.key -out $dir/ca.crt

for target in server client
do
  openssl genrsa -out $dir/$target.key 4096
  openssl req -subj $(subj $target) -new -key $dir/$target.key -out $dir/$target.csr
  openssl x509 -req -days 3650 -in $dir/$target.csr -CA $dir/ca.crt -CAkey $dir/ca.key -CAcreateserial -out $dir/$target.crt
done

chmod 400 $dir/*.key
sudo chown 999 $dir/*.key

echo "DONE - files are in $dir"
