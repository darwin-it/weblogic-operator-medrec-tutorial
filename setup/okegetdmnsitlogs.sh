#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oke_env.sh
echo Get situational config logs for $WLS_DMN_NS server medrec-domain-adminserver
kubectl -n $WLS_DMN_NS logs medrec-domain-adminserver | grep -i situational
