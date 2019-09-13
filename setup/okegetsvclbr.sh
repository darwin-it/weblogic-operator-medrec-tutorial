#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oke_env.sh
echo Get service traefik
kubectl get service -n traefik
