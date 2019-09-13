#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/oke_env.sh
echo Delete Weblogic Operator $WL_OPERATOR_NAME
cd $HELM_CHARTS_HOME
helm del --purge $WL_OPERATOR_NAME 
cd $SCRIPTPATH
