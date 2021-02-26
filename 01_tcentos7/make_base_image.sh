# Create a folder for our new root structure
export centos_root='/centos_image/rootfs'
mkdir -p $centos_root
# initialize rpm database
rpm --root $centos_root --initdb
# download and install the centos-release package, it contains our repository sources
yum reinstall --downloadonly --downloaddir . centos-release
rpm --root $centos_root -ivh centos-release*.rpm
rpm --root $centos_root --import  $centos_root/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
install yum without docs and install only the english language files during the process
yum -y --installroot=$centos_root --setopt=tsflags='nodocs' --setopt=override_install_langs=en_US.utf8 install yum
# configure yum to avoid installing of docs and other language files than english generally
sed -i "/distroverpkg=centos-release/a override_install_langs=en_US.utf8\ntsflags=nodocs" $centos_root/etc/yum.conf

# chroot to the environment and install some additional tools
cp /etc/resolv.conf $centos_root/etc
chroot $centos_root /bin/bash <<EOF
yum install -y procps-ng iputils
yum clean all
EOF


rm -f $centos_root/etc/resolv.conf

# install and enable docker
yum install -y docker

systemctl start docker
# create docker image

#tar -C $centos_root -c . | docker import - centos
tar -C $centos_root -c .
