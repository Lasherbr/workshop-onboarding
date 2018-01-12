# Gluster Demo Basica #

Demo basica de gluster com 3 nos. O playbook:

- Cria 6 discos (2 para cada no)
- Cria 3 Instancias (gluster1, 2 e 3)
- Subscreve as instancias usando credenciais no vault (instrucoes abaixo)
- Instala RedHat Storage
- Cria particao XFS e monta em /data/brick1 em cada instancia
- Conecta as 3 instancias em um cluster Gluster


### Como Usar? ###

* Primeiramente editar o arquivo demo_gluster_create.yml e substituir todas as vars com os dados de sua conta GCE
* Remover o arquivo roles/gluster/vars/main.yml e criar um novo vault com o comando:
ansible-vault create roles/gluster/vars/main.yml
E o seguinte conteudo:
user_subscription:"seuemail@redhat.com"
pass_subscription:"suasenha"
* Rodar ansible-playbook demo_gluster_create.yml --ask-vault-pass

### Como demonstrar gluster? ###

Em qualquer uma das maquinas, criar os volumes de Replica, Distributed e Striped da seguinte forma:

-- Replica
gluster volume create replica1 replica 2 gluster1:/data/brick1/replica1 gluster2:/data/brick1/replica1
gluster volume start replica1

-- Distribuido
gluster volume create distribuido1 gluster1:/data/brick1/distributed1 gluster2:/data/brick1/distributed1 gluster3:/data/brick1/distributed1
gluster volume start distribuido1

-- Striped
gluster volume create striped1 stripe 2 transport tcp gluster1:/data/brick1/striped1 gluster2:/data/brick1/striped1
gluster volume start striped1

Voce pode mostrar os volumes com:

gluster volume info

E o mais divertido... montar e fazer testes:

mkdir /mnt/replica
mkdir /mnt/distribuido
mkdir /mnt/striped

mount -t glusterfs gluster1:/replica1 /mnt/replica
mount -t glusterfs gluster2:/distribuido1 /mnt/distribuido
mount -t glusterfs gluster3:/striped1 /mnt/striped

time dd if=/dev/zero of=/mnt/replica/zeros count=100000 (usualmente o maior tempo, pois tem q replicar)
time dd if=/dev/zero of=/mnt/distribuido/zeros count=100000 (usualmente o menor tempo, pois apenas precisa distribuir)
time dd if=/dev/zero of=/mnt/striped/zeros count=100000 (usualmente tempo medio, pois nao precisa replicar, mas precisa dispersar)



for i in `seq -w 1 100`; do cp -rp /var/log/messages /mnt/replica/copy-test-$i; done
for i in `seq -w 1 100`; do cp -rp /var/log/messages /mnt/distribuido/copy-test-$i; done
for i in `seq -w 1 100`; do cp -rp /var/log/messages /mnt/striped/copy-test-$i; done

Ai pode ver direto nos bricks:

ls -la /data/brick1/replica1/ | wc -l (vai listar mais de 100 porque esta replicado)
ls -la /data/brick1/distributed1 | wc -l (vai listar pouco mais de 50 porque esta distribuido)
ls -la /data/brick1/striped1| wc -l (vai listar mais de 100 mas arquivos menores - listar sem wc -l pra checar)


### Configuracao Openshift ###

1 - Entrar na maquina openshift1 (master) criar uma chave-ssh (ssh-keygen) e copiar a chave publica para os metadados do seu projeto no google (~.ssh/id_rsa.pub). Crie a chave de root.
2 - Alterar o DNS para as respectivas maquinas openshift1, 2 e 3 para master, node1 e node2.
3 - Alterar o resolv.conf para o DNS (pode ser feito antes do provisionamento se alterar a role postsinstall ja com o endereco correto)
4 - Editar inventario base na master (/etc/ansible/hosts.ocp) com os parametros que desejar...

ansible-playbook /usr/share/ansible/openshift-ansible/playbooks/byo/openshift-cluster/openshift-metrics.yml -e openshift_metrics_install_metrics=True -e openshift_metrics_hawkular_hostname=hawkular-metrics.example.com

* Mude o que quiser...

### Who do I talk to? ###

* Repo owner or admin
* Other community or team contact
