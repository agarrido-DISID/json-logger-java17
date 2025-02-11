#!/bin/bash

# This script requires the following:
# Anypoint Platform Organization ID

# Command should be called as follows:
# ./deploy-logger-only.sh some-org-id-value

if [ "$#" -ne 1 ]
then
  echo "[ERROR] You need to provide your OrgId"
  exit 1
fi
echo "Deploying JSON Logger to Exchange"
echo "> OrgId: $1"

# Replacing ORG_ID_TOKEN inside pom.xml with OrgId value provided from command line
echo "Replacing OrgId token..."

echo sed -i.bkp "s/ORG_ID_TOKEN/$1/g" pom.xml
sed -i.bkp "s/ORG_ID_TOKEN/$1/g" pom.xml

# Deploying to Exchange
echo "Deploying to Exchange..."

echo mvn -f pom.xml clean deploy -s exchange-docs/template-files/settings.xml
mvn -f pom.xml clean deploy -s exchange-docs/template-files/settings.xml

if [ $? != 0 ]
then
  echo "[ERROR] Failed deploying json-logger-java17 to Exchange"
  exit 1
fi
