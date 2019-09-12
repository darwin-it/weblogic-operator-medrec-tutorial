#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oke_env.sh
echo K8s Check weblogic operator version
#kubectl -n weblogic-operator get deploy weblogic-operator -o yaml
kubectl -n $K8S_NS get deploy weblogic-operator -o yaml
