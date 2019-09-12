#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oke_env.sh
echo K8s Can I deploy as system?
kubectl auth can-i create deploy --as system:serviceaccount:kube-system:default
