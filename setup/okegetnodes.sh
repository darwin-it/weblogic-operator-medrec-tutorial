#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oek_env.sh
echo Get K8s nodes
kubectl get node
