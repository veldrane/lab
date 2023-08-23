### This is the general README file for my home LAB environment ###

#### General

This stuff is mostly deprecated and i am trying to prepare new environment based on the openvswitch (original setup uses linux bridge) and 
i would like to rewrite all stuff to terraform, because all ansible playbooks heavy use the shell plugin :). 


#### HW setup ####

Whole lab is running on the DL380 G8 with 128GB RAM and 512GB diskarray (mirror on P420i smartcontroller).
For the virtualization layer is used the kvm but I plane to use vmware as well
because of the enterprise standard.


#### OS setup ####

Centos 8 with kvm is used for this purpose.


#### KVM setup ####

All virtual hosts are connected via virtual bridges and whole 10.1.x.0/16 network are dedicated for this purpose. This network is divided to C segments so each virbr has own number number and this represents third octec.

For example:

virbr8 -> 10.1.8.0/24
virbr16 -> 10.1.16.0/24
.

Gateway is configured to the first host in the subnet (10.1.x.1). At the moment are configured just two bridges:
  - virbr8: is used for general purpose and shared svc like a IPA, Postgre server,  keycloak, jumpoint, registry etc.

  - virbr16: is used for okd and k8s server

If you need a create new bridge lets have a directory 00_proliant where the simple scripts are prepared.

#### Directories ####


**00_proliant:** Scripts for initial configuration and creation of the virtual networks inside the kvm

**01_tcentos7:** Kickstart and scripts for deploying initial centos7 template, whis is used for almost all machines created on the cluster

**02_freeipa:** Shell scripts and ansible roles for ipa server instalation. Ipa is core component and all servers are intergrated in the domain.

**03_okdv3:** Ansible playbooks and scripts for openshift (okd version) version 3.

**04_pgserver:** Ansible playbook and scripts for postgresql server. This component is necessary for various ther tools like a keycloak, nginx controller etc

**05_k8s:** Playbooks, scripts and othe stuff for Kubernetes deployment. There aome roles with calico cni or with antrea cni (my prefered way - similar to ocp3 cni). For lab purpose i used only one master, two gw nodes and 5 workers.

**06_registry:** Dedicated docker registry server.

**07_buildnode:** Jumpoint for other stuff like a okd3 and k8s. Various management tools installed

**08_keycloak:** IdP for k8s server, nginx proxies etc. Integrated with Ipa 

**09_apigw:**: various apigw configuration on various product (nginx, krakend, maybe kong-ce). Focused mostly on kubernetes and OIDC integration (keycloak)

**10_nfs:** NFS for all nodes in the kvm cluster. Mounts are accomplished via automounter, uses nfs4 and kerberos authentication (i played with krb5p options as well but it was really slow). All kerberos stuff are configured agains ipa (all vms are part of the ipa domain)

**11_stress-ng:** VM for stress-ng test

**12_rpinode:** emulated arm raspberry pi node

**15_prometheus:**: prometheus node deployment roles, prometheus works like a part of k8s cluster.

**16_elk:**: some basic elasticear deployment, mostly used for elkpump scripts test (advanced strace analysis - see specail repo).

**99_newhost:** Base ansible playbook for deployment new host. Most important directory in the project. All other stuffs have a just a link to the playbooks and a have own configuration include file


Other directories are just temporary or doesn't have any special purpose.
