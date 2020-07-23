#!/bin/bash

if [ $# -ne 5 ]; then
  echo 1>&2 "Usage: . $0 hostname realm username clientid"
  echo 1>&2 "  options:"
  echo 1>&2 "    hostname: localhost:8081"
  echo 1>&2 "    realm:keycloak-demo"
  echo 1>&2 "    clientid:demo"
  echo 1>&2 "    client-secret:x 42734911-3cbd-4a20-a426-83cb208edc43"
  echo 1>&2 "    For verify ssl: use 'y' (otherwise it will send curl post with --insecure)"
  
  return
fi

HOSTNAME=$1
REALM_NAME=$2
USERNAME=$3
CLIENT_ID=$4
CLIENT_SECRET=$5
SECURE=$6
PASSWORD=Heslo1234



#KEYCLOAK_URL=https://$HOSTNAME/auth/realms/$REALM_NAME/protocol/openid-connect/token
KEYCLOAK_URL=https://$HOSTNAME/auth/realms/$REALM_NAME/protocol/openid-connect/token



#echo "Using Keycloak: $KEYCLOAK_URL"
#echo "realm: $REALM_NAME"
#echo "client-id: $CLIENT_ID"
#echo "username: $USERNAME"
#echo "client-secret: $CLIENT_SECRET"
#echo "secure: $SECURE"


if [[ $SECURE = 'y' ]]; then
	INSECURE=
else 
	INSECURE=--insecure
fi


#echo -n Password: 
#read -s PASSWORD


export TOKEN=$(curl -X POST "$KEYCLOAK_URL" "$INSECURE" \
 -H "Content-Type: application/x-www-form-urlencoded" \
 -d "username=$USERNAME" \
 -d "password=$PASSWORD" \
 -d 'grant_type=password' \
 -d "client_id=$CLIENT_ID" \
 -d "client_secret=$CLIENT_SECRET" \
 -d "scope=groups openid" 2>/dev/null )

echo $TOKEN

if [[ $(echo $TOKEN) != 'null' ]]; then
	export KEYCLOAK_TOKEN=$TOKEN
fi
