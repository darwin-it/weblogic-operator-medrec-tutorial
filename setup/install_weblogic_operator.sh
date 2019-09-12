#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oke_env.sh
echo Install Weblogic Operator $WL_OPERATOR_NAME
cd $HELM_CHARTS_HOME
helm install kubernetes/charts/weblogic-operator \
  --name $WL_OPERATOR_NAME \
  --namespace $K8S_NS \
  --set image=oracle/weblogic-kubernetes-operator:2.0 \
  --set serviceAccount=$K8S_NS:$K8S_SA \
  --set "domainNamespaces={}"
cd $SCRIPTPATH
