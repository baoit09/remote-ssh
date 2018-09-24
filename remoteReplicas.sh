#!/bin/bash
set -e
n=1 ; eval a$n="13.229.71.175"
n=2 ; eval a$n="54.255.205.146"
n=3 ; eval a$n="54.179.187.79"
n=4 ; eval a$n="54.255.236.246"
n=5 ; eval a$n="18.136.105.95"
n=6 ; eval a$n="18.136.104.14"
n=7 ; eval a$n="13.250.112.83"
n=8 ; eval a$n="52.221.181.66"
n=9 ; eval a$n="54.169.140.0"

for i in 1 2 3 4 5 6 7 8 9
do
    eval ip=\$a$i
    echo ${ip}
    R=$(( $i - 1 ))
    scp -i /home/datlv/Documents/deevo/key/dev-full-rights.pem /home/datlv/Documents/deevo/configproduction/node.config ubuntu@${ip}:/opt/gopath/src/github.com/hyperledger/hyperledger-bftsmart-orderering/config/node.config
    scp -i /home/datlv/Documents/deevo/key/dev-full-rights.pem /home/datlv/Documents/deevo/sshscriptproduction/runreplica/hosts-${R}.config ubuntu@${ip}:/opt/gopath/src/github.com/hyperledger/hyperledger-bftsmart-orderering/config/hosts.config
    scp -i /home/datlv/Documents/deevo/key/dev-full-rights.pem /home/datlv/Documents/deevo/sshscriptproduction/runreplica/system.config ubuntu@${ip}:/opt/gopath/src/github.com/hyperledger/hyperledger-bftsmart-orderering/config/system.config
    scp -i /home/datlv/Documents/deevo/key/dev-full-rights.pem /home/datlv/Documents/deevo/sshscriptproduction/runreplica/RunReplica-${R}.sh ubuntu@${ip}:/opt/gopath/src/github.com/hyperledger/hyperledger-bftsmart-orderering/RunReplica.sh
    scp -i /home/datlv/Documents/deevo/key/dev-full-rights.pem /home/datlv/Documents/deevo/configproduction/genesis.block ubuntu@${ip}:/home/ubuntu/hyperledgerconfig/data/genesis.block
    scp -i /home/datlv/Documents/deevo/key/dev-full-rights.pem /home/datlv/Documents/deevo/configproduction/key.pem ubuntu@${ip}:/home/ubuntu/hyperledgerconfig/data/key.pem
    scp -i /home/datlv/Documents/deevo/key/dev-full-rights.pem /home/datlv/Documents/deevo/configproduction/cert.pem ubuntu@${ip}:/home/ubuntu/hyperledgerconfig/data/cert.pem
    if [ ${i} -eq 9 ]  ;  then
        scp -i /home/datlv/Documents/deevo/key/dev-full-rights.pem /home/datlv/Documents/deevo/sshscriptproduction/runreplica/RunFrontend.sh ubuntu@${ip}:/opt/gopath/src/github.com/hyperledger/hyperledger-bftsmart-orderering/RunFrontend.sh
    else
        ssh -p 22 -i /home/datlv/Documents/deevo/key/dev-full-rights.pem ubuntu@${ip} 'if [ $(pidof java) ] ; then kill $(pidof java) ; fi; cd /opt/gopath/src/github.com/hyperledger/hyperledger-bftsmart-orderering/; ./RunReplica.sh; exit;'
    fi
done

