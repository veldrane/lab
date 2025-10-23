
## get BOUNDARY_TOKEN
## oundary authenticate password --auth-method-id ampw_KmTMXpvcW1 -login-name admin
export LDAP_PASSWORD=boundary1234


boundary auth-methods create ldap \
  -name "lab.syscallx86.com ldap" \
  -description "FreeIPA server as LDAP provider" \
  -urls "ldap://10.1.8.10:389" \
  -bind-dn "uid=boundary-bind,cn=users,cn=accounts,dc=lab,dc=syscallx86,dc=com" \
  -bind-password env://LDAP_PASSWORD \
  -user-dn "cn=users,cn=accounts,dc=lab,dc=syscallx86,dc=com" \
  -group-dn "cn=groups,cn=accounts,dc=lab,dc=syscallx86,dc=com" \
  -user-attr "uid" \
  -group-attr "cn" \
  -insecure-tls \
  -token env://BOUNDARY_TOKEN