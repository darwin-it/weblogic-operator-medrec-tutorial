#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oke_env.sh
echo Create cluster role binding
echo kubectl create clusterrolebinding makker-cluster-admin-binding --clusterrole=cluster-admin --user=$OCID_USER
kubectl create clusterrolebinding makker-cluster-admin-binding --clusterrole=cluster-admin --user=$OCID_USER
