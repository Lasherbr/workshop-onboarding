[OSEv3:children]
nodes
masters
nfs
etcd

[OSEv3:vars]
openshift_master_cluster_public_hostname=None
openshift_master_default_subdomain=example.com
ansible_ssh_user=root
openshift_master_cluster_hostname=None
openshift_override_hostname_check=true
deployment_type=openshift-enterprise

[nodes]
master.example.com  openshift_public_ip=35.198.58.23 openshift_ip=10.158.0.2 openshift_public_hostname=35.198.58.23 openshift_hostname=openshift1 openshift_schedulable=False ansible_connection=local
node1.example.com  openshift_public_ip=35.198.48.249 openshift_ip=10.158.0.3 openshift_public_hostname=35.198.48.249 openshift_hostname=openshift2 openshift_node_labels="{'region': 'infra'}" openshift_schedulable=True
node2.example.com  openshift_public_ip=35.198.32.188 openshift_ip=10.158.0.4 openshift_public_hostname=35.198.32.188 openshift_hostname=openshift3 openshift_node_labels="{'region': 'infra'}" openshift_schedulable=True
infra-node1.example.com  openshift_public_ip=35.199.102.33 openshift_ip=10.158.0.6 openshift_public_hostname=35.199.102.33 openshift_hostname=openshift4 openshift_schedulable=True

[masters]
master.example.com  openshift_public_ip=35.198.58.23 openshift_ip=10.158.0.2 openshift_public_hostname=35.198.58.23 openshift_hostname=openshift1 ansible_connection=local

[nfs]
master.example.com  openshift_public_ip=35.198.58.23 openshift_ip=10.158.0.2 openshift_public_hostname=35.198.58.23 openshift_hostname=openshift1 ansible_connection=local

[etcd]
master.example.com  openshift_public_ip=35.198.58.23 openshift_ip=10.158.0.2 openshift_public_hostname=35.198.58.23 openshift_hostname=openshift1 ansible_connection=local

