yum install -y ipa-client sssd openldap-clients krb5-workstation
authconfig --enablemkhomedir --update
ipa-join
