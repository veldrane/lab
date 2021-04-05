#### Procedure for deploy k8s cluster with oidc auth schema

##### Setup

IdP: 
  - server: keycloak server keycloak.lab.local:8443
  - client: kube
  - client secret: 93f43a10-896f-429a-b740-b1d35747495b
  - integration with ipa
  - keycloak need to have valid cert (no selfsigned) singed by ipa
  - group k8s-cluster-admin is bind like cluster-admin in k8s cluster

K8s:
  - master: node11.lab.local
  - client machine: build.lab.local

##### Master server node11.lab.local

- copy ipa ca cert to /etc/kubernetes/pki directory:

```
cp /etc/ipa/ca.crt /etc/kubernetes/pki/lab.local.pem
```

- add following options to /etc/kubernetes/manifest/kube-apiserver.yaml to kube-apiserver parameters section:

```
    - --oidc-ca-file=/etc/kubernetes/pki/lab.local.pem
    - --oidc-issuer-url=https://keycloak.lab.local:8443/auth/realms/lab
    - --oidc-client-id=kube
    - --oidc-groups-claim=groups
    - '--oidc-groups-prefix=oidc:groups:'
    - --oidc-username-claim=username
    - '--oidc-username-prefix=oidc:users:'
```

- create cluster role binding to bind oidc group with cluster-admin role

```
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  annotations:
  name: oidc:cluster-admin
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: Group
  name: oidc:groups:k8s-cluster-admin
```

##### Client - in this case build.lab.local

- oidc credentials for certain user

```
 kubectl config set-credentials veldrane/node11.lab.local --exec-api-version=client.authentication.k8s.io/v1beta1 --exec-command=kubectl --exec-arg=oidc-login --exec-arg=get-token --exec-arg=--oidc-issuer-url=https://keycloak.lab.local:8443/auth/realms/lab --exec-arg=--oidc-client-id=kube --exec-arg=--oidc-client-secret=93f43a10-896f-429a-b740-b1d35747495b --exec-arg=--username=veldrane
```


- set cluster to .kube/config

```
kubectl config set-cluster node11.lab.local --insecure-skip-tls-verify=true --server=https://node11.lab.local:6443
```

- set context 

```
kubectl config set-context default/node11.lab.local/veldrane --user=veldrane/node11.lab.local --namespace=default --cluster=node11.lab.local
```

- switch to new context

```
kubectl config use-context default/node11.lab.local/veldrane
```

- install krew plugin

```
set -x; cd "$(mktemp -d)" &&   OS="$(uname | tr '[:upper:]' '[:lower:]')" &&   ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&   curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" &&   tar zxvf krew.tar.gz &&   KREW=./krew-"${OS}_${ARCH}" &&   "$KREW" install krew
```

- install kube login plugin

```
kubectl krew install oidc-login
```

- try to get nodes


Last two steps are nice describe at: https://krew.sigs.k8s.io/docs/user-guide/setup/install/
