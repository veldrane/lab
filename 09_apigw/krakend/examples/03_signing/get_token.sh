token=`curl http://krakend.lab.local/token -q`
echo $token | jq .access_token | awk -F. '{print $1}' | sed -E "s/\"//g" | base64 -d | jq .
echo $token | jq .access_token | awk -F. '{print $2}' | base64 -d | jq .
