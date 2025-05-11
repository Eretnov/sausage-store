#! /bin/bash

set -xe
curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store.tar.gz ${NEXUS_REPO_URL}/${NEXUS_REPO_FRONTEND_NAME}/${VERSION}/sausage-store-${VERSION}.tar.gz
sudo tar -xzvf ./sausage-store.tar.gz -C /tmp/ && rm -f ./sausage-store.tar.gz
sudo rm -f /tmp/frontend/.gitlab-ci.yml /tmp/frontend/deploy.sh
sudo rm -rf /opt/sausage-store/static/*
sudo cp -Rf /tmp/frontend/* /opt/sausage-store/static/ && sudo rm -rf /tmp/frontend/ 
sudo chown -R frontend: /opt/sausage-store/static/
sudo systemctl reload nginx
