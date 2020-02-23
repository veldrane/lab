
--- Install oc client

wget https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz -O /tmp/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz

tar xvfz /tmp/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit/oc -C /usr/local/bin --strip-components=1

--- Customize /etc/environment
