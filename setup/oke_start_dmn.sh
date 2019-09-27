#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oke_env.sh
echo Start Domain $K8S_DMN_NAME
export SVR_STRT_POLICY="IF_NEEDED"
WLS_DMN_YAML_TPL=${WLS_DMN_YAML}.tpl
envsubst < $WLS_DMN_YAML_TPL > $WLS_DMN_YAML
kubectl apply -f $WLS_DMN_YAML
