kubectl config set-credentials oidc --exec-api-version=client.authentication.k8s.io/v1beta1 --exec-command=kubectl --exec-arg=oidc-login --exec-arg=get-token --exec-arg=--oidc-issuer-url=https://secure-keycloak-keycloak.route.local/auth/realms/lab --exec-arg=--oidc-client-id=kube --exec-arg=--oidc-client-secret=28e9bcc5-f4ff-48e6-8834-c9e2d1f55bdf --exec-arg=--username=veldrane@lab.local

