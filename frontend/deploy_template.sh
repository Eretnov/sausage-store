#! /bin/bash
set -xe
sudo docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
sudo docker network create -d bridge sausage_network || true
sudo docker rm -f sausage-frontend || true
sudo docker run --rm -d --name sausage-frontend \
     --network=sausage_network \
     --restart=on-failure:15 \
     --publish 80:80 \
     --volume "/tmp/${CI_PROJECT_DIR}/frontend/default.conf:/etc/nginx/conf.d/default.conf" \
     "${CI_REGISTRY_IMAGE}"/sausage-frontend:${VERSION}

