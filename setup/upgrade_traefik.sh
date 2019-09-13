#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oke_env.sh
echo Upgrade traefik with namespace $WLS_DMN_NS
cd $HELM_CHARTS_HOME
helm upgrade \
  --reuse-values \
  --set "kubernetes.namespaces={traefik,$WLS_DMN_NS}" \
  --wait \
  traefik-operator \
  stable/traefik

cd $SCRIPTPATH
