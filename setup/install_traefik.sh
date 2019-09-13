#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oke_env.sh
echo Install traefik
cd $HELM_CHARTS_HOME
helm install stable/traefik \
--name traefik-operator \
--namespace traefik \
--values kubernetes/samples/charts/traefik/values.yaml  \
--set "kubernetes.namespaces={traefik}" \
--set "serviceType=LoadBalancer"
cd $SCRIPTPATH
