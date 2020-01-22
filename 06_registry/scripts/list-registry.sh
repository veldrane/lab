registry="registry.lab.local"
repos=`curl -k https://$registry/v2/_catalog?n=100 | jq '.repositories[]' | tr -d '"'`
for repo in $repos; do 
   curl -k https://$registry/v2/$repo/tags/list; 
done
