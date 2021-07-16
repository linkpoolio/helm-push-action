#!/bin/bash
set -e

if [ -z "$CHARTMUSEUM_URL" ]; then
  echo "CHARTMUSEUM_URL is not set. Quitting."
  exit 1
fi

if [ -z "$CHARTMUSEUM_USER" ]; then
  echo "CHARTMUSEUM_USER is not set. Quitting."
  exit 1
fi

if [ -z "$CHARTMUSEUM_PASSWORD" ]; then
  echo "CHARTMUSEUM_PASSWORD is not set. Quitting."
  exit 1
fi

if [ -z "$SOURCE_DIR" ]; then
  SOURCE_DIR="."
fi

if [ -z "$FORCE" ]; then
  FORCE=""
elif [ "$FORCE" == "1" ] || [ "$FORCE" == "True" ] || [ "$FORCE" == "TRUE" ]; then
  FORCE="-f"
fi



cd ${SOURCE_DIR}

for CHART in */ ; do

  cd $CHART

  helm version -c

  helm inspect chart .

  helm dependency update .

  helm package .

  helm push ${CHART}-* ${CHARTMUSEUM_URL} -u ${CHARTMUSEUM_USER} -p ${CHARTMUSEUM_PASSWORD} ${FORCE}

  cd -
done