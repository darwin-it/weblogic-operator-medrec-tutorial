#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oke_env.sh
#
function prop {
    grep "${1}" $SCRIPTPATH/credentials.properties|cut -d'=' -f2
}
#
MR_DB_USER=$(prop 'db.medrec.username')
MR_DB_PWD=$(prop 'db.medrec.password')
MR_DB_URL=$(prop 'db.medrec.url')
#
echo Delete Medrec DB Secret $MR_DB_CRED for $WLS_DMN_NS
kubectl -n $WLS_DMN_NS delete secret $MR_DB_CRED
echo Create Medrec DB Secret $MR_DB_CRED for $MR_DB_USER and URL $MR_DB_URL
kubectl -n $WLS_DMN_NS create secret generic $MR_DB_CRED --from-literal=username=$MR_DB_USER --from-literal=password=$MR_DB_PWD --from-literal=url=$MR_DB_URL
kubectl -n $WLS_DMN_NS label secret $MR_DB_CRED weblogic.domainUID=$WLS_DMN_UID
#
SMPL_DB_CRED=dbsecret
echo Delete Medrec DB Secret $SMPL_DB_CRED for $WLS_DMN_NS
kubectl -n $WLS_DMN_NS delete secret $SMPL_DB_CRED
echo Create DB Secret dbsecret $SMPL_DB_CRED for  $WLS_DMN_NS
kubectl -n $WLS_DMN_NS create secret generic $SMPL_DB_CRED --from-literal=username=scott2 --from-literal=url=jdbc:oracle:thin:@test.db.example.com:1521/ORCLCDB
kubectl -n $WLS_DMN_NS label secret $SMPL_DB_CRED weblogic.domainUID=$WLS_DMN_UID


