#!/bin/bash
docker pull jc21/registry-ui:latest
docker tag jc21/registry-ui registry.lab.local/openshift/registry-ui:latest
docker push registry.lab.local/openshift/registry-ui:latest

docker run -d -it -p 80:80 -e REGISTRY_HOST=registry.lab.local:443 -e REGISTRY_STORAGE_DELETE_ENABLED=true -e REGISTRY_SSL=true -e REGISTRY_DOMAIN=registry.lab.local:443 --name registry-ui registry.lab.local/openshift/registry-ui:latest
