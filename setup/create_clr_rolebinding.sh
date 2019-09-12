#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oek_env.sh
echo Create cluster role binding
echo kubectl create clusterrolebinding my-cluster-admin-binding --clusterrole=cluster-admin --user=$OCID_USER
kubectl create clusterrolebinding my-cluster-admin-binding --clusterrole=cluster-admin --user=$OCID_USER
