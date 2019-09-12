#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oke_env.sh
echo Create helm-user-cluster-admin-role
cat << EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: helm-user-cluster-admin-role
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: default
  namespace: kube-system
EOF
echo Create namespace $K8S_NS
kubectl create namespace $K8S_NS
echo kubectl create serviceaccount -n $K8S_NS $K8S_SA
kubectl create serviceaccount -n $K8S_NS $K8S_SA
