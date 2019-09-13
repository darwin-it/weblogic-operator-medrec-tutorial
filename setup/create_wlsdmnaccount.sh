#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oke_env.sh
#
function prop {
    grep "${1}" $SCRIPTPATH/credentials.properties|cut -d'=' -f2
}
#
echo Create weblogic domain namespace $WLS_DMN_NS
kubectl create namespace $WLS_DMN_NS
WLS_USER=$(prop 'weblogic.user')
WLS_PWD=$(prop 'weblogic.password')
echo Create a Kubernetes secret $WLS_DMN_CRED in namespace $WLS_DMN_NS containing the Administration Server boot credentials for user $WLS_USER
kubectl -n $WLS_DMN_NS create secret generic $WLS_DMN_CRED \
  --from-literal=username=$WLS_USER \
  --from-literal=password=$WLS_PWD
echo Label the $WLS_DMN_CRED in namespace $WLS_DMN_NS secret with domainUID $WLS_DMN_NAME
kubectl label secret $WLS_DMN_CRED \
  -n $WLS_DMN_NS \
  weblogic.domainUID=$WLS_DMN_NAME \
  weblogic.domainName=$WLS_DNM_NAME \
  --overwrite=true
echo Create secret for oci image repository $OCIR_CRED
OCIR_USER=$(prop 'ocir.user')
OCIR_PWD=$(prop 'ocir.password')
OCIR_EMAIL=$(prop 'ocir.email')
OCI_TEN=$(prop 'oci.tenancy')
OCI_REG=$(prop 'oci.region')
kubectl create secret docker-registry $OCIR_CRED \
  -n $K8S_NS \
  --docker-server=${OCI_REG}.ocir.io \
  --docker-username="${OCI_TEN}/${OCIR_USER}" \
  --docker-password="${OCIR_PWD}" \
  --docker-email="${OCIR_EMAIL}"

