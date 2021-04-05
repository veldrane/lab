#### create new certs signed by ipa

- create csr and key
```
openssl req -nodes -newkey rsa:2048 -keyout keycloak.lab.local.key -out keycloak.lab.local.csr -subj "/O=LAB.LOCAL/CN=keycloak.lab.local"
```
- then sign csr with ca via gui (must be improved - signed by command, we need to automate the process)
- than convert to pkcs12 format
```
openssl pkcs12 -export -out keycloak.lab.local.pkcs12 -in keycloak.lab.local.pem -inkey keycloak.lab.local.key
```
- than import to application.keystore via keytool command. Important: no specify the alias!!!
```
keytool -importkeystore -srckeystore keycloak.lab.local.pkcs12 -destkeystore application.keystore -srcstoretype pkcs12
```
- change the alias 
```
keytool -changealias -keystore application.keystore -alias 1
```

