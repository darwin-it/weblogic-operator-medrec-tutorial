#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oek_env.sh
echo setup OCI
oci setup config
