#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oke_env.sh
echo Describe jdbc configuration map of $WLS_DMN_NS
kubectl describe cm jdbccm -n $WLS_DMN_NS
