#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oke_env.sh
echo Upgrade Weblogic Operator $WL_OPERATOR_NAME with domainNamespace $WLS_DMN_NS
cd $HELM_CHARTS_HOME
helm upgrade \
  --reuse-values \
  --set "domainNamespaces={$WLS_DMN_NS}" \
  --wait \
  $WL_OPERATOR_NAME \
  kubernetes/charts/weblogic-operator
cd $SCRIPTPATH
