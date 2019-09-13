#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oke_env.sh
echo Upgrade traefik with namespace $WLS_DMN_NS
cat << EOF | kubectl apply -f -
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: traefik-pathrouting-1
  namespace: $WLS_DMN_NS
  annotations:
    kubernetes.io/ingress.class: traefik
spec:
  rules:
  - host:
    http:
      paths:
      - path: /
        backend:
          serviceName: medrec-domain-cluster-medrec-cluster
          servicePort: 8001
      - path: /console
        backend:
          serviceName: medrec-domain-adminserver
          servicePort: 7001          
EOF

