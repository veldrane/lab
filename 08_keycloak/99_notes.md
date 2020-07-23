#### Groups propagation ####

Groups mapper in the client must have disabled option "Full group path" to preserve prefix "/" 

#### Sync with ipa #####

Setup is provided by options in "User federation" -> "Settings" -> "Sync settings"

Enable "Periodic full sync"

- must be considered the load of the full sync vs changed user sync and ad/disad

#### Install steps ####

##### Keycloak #####

lvcreate -L4GiB -n opt rootvg
mkfs.ext4 /dev/rootvg/opt
echo "/dev/mapper/rootvg-opt  /opt                    ext4    noatime,nodiratime        1 2" >> /etc/fstab
mount /opt
yum install -y java-1.8.0-openjdk
cd /tmp ; curl https://downloads.jboss.org/keycloak/9.0.3/keycloak-9.0.3.tar.gz -o keycloak-9.0.3.tar.gz
mkdir -p /opt/keycloak/9.0.3
ln -s /opt/keycloak/9.0.3 /opt/keycloak/current
tar -xzf /tmp/keycloak-9.0.3.tar.gz -C /opt/keycloak/9.0.3 --strip-components=1
chmod 700 /opt/keycloak/current/standalone
cd /opt/keycloak/current/modules 
mkdir -p org/postgresql/main
curl https://jdbc.postgresql.org/download/postgresql-42.2.12.jar -o org/postgresql/main/postgresql-42.2.12.jar


```echo '<?xml version="1.0" ?>
<module xmlns="urn:jboss:module:1.3" name="org.postgresql">

    <resources>
        <resource-root path="postgresql-42.2.12.jar"/>
	</resources>

	<dependencies>
		<module name="javax.api"/>
		<module name="javax.transaction.api"/>
	</dependencies>
</module>' > org/postgresql/main/module.xml```

```echo '[Unit]
Description=Keycloak
After=network.target syslog.target

[Service]
Type=idle
User=keycloak
Group=keycloak
ExecStart=/opt/keycloak/current/bin/standalone.sh -b 0.0.0.0
TimeoutStartSec=600
TimeoutStopSec=600

StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=keycloak

[Install]
WantedBy=multi-user.target
' > /etc/systemd/system/keycloak.service```
systemctl deamon-reload
systemctl enable keycloak


chown -R keycloak.keycloak-admin /opt/keycloak
cd /opt/keycloak/current
./bin/add-user-keycloak.sh -u admin -p admin -r master


##### IPA #####

ipa group-add keycloak-admin --gid=10012 --desc='Keycloak admins'
echo keycloak | ipa user-add keycloak --first=Keycloak --last=Keycloak --homedir=/var/lib/keycloak --shell=/sbin/nologin --uid=1006 --gidnumber=10012 --password

