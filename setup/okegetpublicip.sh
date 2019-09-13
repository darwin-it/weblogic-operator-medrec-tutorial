#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oke_env.sh
echo Get traefik public IP
kubectl describe svc traefik-operator --namespace traefik | grep Ingress | awk '{print $3}'
