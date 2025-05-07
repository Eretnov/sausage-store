#! /bin/bash

set -xe
curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store.tar.gz ${NEXUS_REPO_URL}/${NEXUS_REPO_FRONTEND_NAME}/${VERSION}/sausage-store-${VERSION}.tar.gz
sudo rm -rf /opt/sausage-store/static/*
sudo tar -xzvf ./sausage-store.tar.gz -C /opt/sausage-store/static/ && rm -f ./sausage-store.tar.gz
sudo chown -R frontend: /opt/sausage-store/static/
sudo systemctl reload nginx
