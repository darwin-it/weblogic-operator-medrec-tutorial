#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oke_env.sh
echo Get K8s pods for kube-system
kubectl -n kube-system get pods
