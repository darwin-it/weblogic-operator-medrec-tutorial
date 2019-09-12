#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oke_env.sh
echo K8s Can I deploy?
kubectl auth can-i create deploy
