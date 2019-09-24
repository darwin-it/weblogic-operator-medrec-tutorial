#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oke_env.sh
echo Delete configuration map jdbccm for Domain $WLS_DMN_UID 
kubectl -n $WLS_DMN_NS delete cm jdbccm
echo Override Weblogic Domain $WLS_DMN_UID using $SCRIPTPATH/medrec-domain/override
kubectl -n $WLS_DMN_NS create cm jdbccm --from-file $SCRIPTPATH/medrec-domain/override
kubectl -n $WLS_DMN_NS label cm jdbccm weblogic.domainUID=$WLS_DMN_UID

