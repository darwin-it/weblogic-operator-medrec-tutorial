#!/bin/bash
echo Set OEK Environment
export OCID_USER="ocid1.user.oc1..aaaaaaaaskfiokyfunhrkse652q4hfqymhea5xr5xvmhjrsrjgqkgtseyima" 
export OCID_TENANCY="ocid1.tenancy.oc1..aaaaaaaa6jjldfvjyf7sjmmnq6gltqetamqeizj5fkuxazlmaxh7mbmgrkpa"
export REGION="eu-frankfurt-1"
export K8S_NS="medrec-weblogic-operator-ns"
export K8S_SA="medrec-weblogic-operator-sa"
export HELM_CHARTS_HOME=/u01/content/weblogic-kubernetes-operator
export WL_OPERATOR_NAME="medrec-weblogic-operator"

