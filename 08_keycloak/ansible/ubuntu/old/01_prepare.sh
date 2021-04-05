#lvcreate -L4GiB -n opt rootvg
#mkfs.ext4 /dev/rootvg/opt
#echo "/dev/mapper/rootvg-opt  /opt                    ext4    noatime,nodiratime        1 2" >> /etc/fstab
#mount /opt
apt-get install -y java-1.8.0-openjdk
#cd /tmp ; curl https://downloads.jboss.org/keycloak/12.0.2/keycloak-12.0.2.tar.gz -o keycloak-12.0.2.tar.gz

curl https://github.com/keycloak/keycloak/releases/download/12.0.2/keycloak-12.0.2.tar.gz -o keycloak-12.0.2.tar.gz

mkdir -p /opt/keycloak/12.0.2
ln -s /opt/keycloak/12.0.2 /opt/keycloak/current
tar -xzf /tmp/keycloak-12.0.2.tar.gz -C /opt/keycloak/12.0.2 --strip-components=1
chmod 700 /opt/keycloak/current/standalone
cd /opt/keycloak/current/modules 
mkdir -p org/postgresql/main
curl https://jdbc.postgresql.org/download/postgresql-42.2.12.jar -o org/postgresql/main/postgresql-42.2.12.jar

