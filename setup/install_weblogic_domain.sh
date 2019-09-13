#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oke_env.sh
echo Install Weblogic Domain from $WLS_DMN_YAML
kubectl apply -f $WLS_DMN_YAML
