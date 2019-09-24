#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oke_env.sh
echo Get K8s pods for $WLS_DMN_NS
kubectl -n $WLS_DMN_NS get pods -o wide| awk '{print $1 " - "  $3}'

