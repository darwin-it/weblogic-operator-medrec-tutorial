#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oek_env.sh
echo Create Kubeconfig -> Copy command from Access Kube Config from cluster
mkdir -p $HOME/.kube
oci ce cluster create-kubeconfig --cluster-id ocid1.cluster.oc1.eu-frankfurt-1.aaaaaaaaaezdcodcgaygmmzvha3dcmbsmeydozrvgy4ten3chc4wmmzvge3g --file $HOME/.kube/config --region eu-frankfurt-1 --token-version 2.0.0 
