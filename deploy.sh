#!/bin/bash

clear
envVarTest1=$(env|grep WWW_TRUSTED_IP |cut -f2 -d=)
if [ -z "$envVarTest1" ]
then
    echo
    echo "Environment variables must be set: "
    echo 
    echo "WWW_TRUSTED_IP: $envVarTest1"
    echo
    exit
fi
keyName=www
stackName="www-codedeploy-$(date +%Y%m%d-%H%M)"
cfnFile="file://cloudformation.json"
echo
echo "$stackName :: $cfnFile"
echo
echo
echo "==> load variables:"
echo
echo
cfnParameters=" ParameterKey=wwwTrustedIP,ParameterValue=$WWW_TRUSTED_IP "
cfnParameters+=" ParameterKey=KeyName,ParameterValue=$keyName "
echo $cfnParameters
echo
echo "==> launch opsworks stack:"
echo
echo
aws cloudformation create-stack --stack-name $stackName --disable-rollback --template-body $cfnFile --parameters $cfnParameters --capabilities CAPABILITY_IAM
echo
echo
