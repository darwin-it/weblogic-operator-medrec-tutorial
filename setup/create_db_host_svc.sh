#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oke_env.sh
echo Upgrade traefik with namespace $WLS_DMN_NS
cat << EOF | kubectl apply -f -
kind: Service
apiVersion: v1
metadata:
 name: medrecdbhostname
spec:
 ports:
 - port: 1521
   targetPort: 1521
---
kind: Endpoints
apiVersion: v1
metadata:
 name: medreck8s.sub40efe034a.medrecokecluste.oraclevcn.com
subsets:
 - addresses:
     - ip: 10.0.10.6
   ports:
     - port: 1521
EOF

