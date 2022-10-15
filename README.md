# Vagrant Hybrid LAB on Virtualbox 


This Vagrantfile make an hybrid lab on virtualbox with Linux, Mac and Windows Machines  

* Default Configuration requires 13GB of free RAM  
* Increase or decrease RAM configuration of any machine if necessary  
  * 4GB of RAM its the minimal required for Windows and MacOSx 
* Dont forget to create the entries on hosts file
  * Linux
    * `/etc/hosts`
  * MacOSx
    * `/etc/hosts`
  * Windows
    * `C:\Windows\system32\drivers\etc\hosts`
* Your Host machine should have NFS Server installed
  * Ubuntu 
    * `sudo apt-get update ; sudo apt-get install nfs-server nfs-common -y`
* On MacOSx step to configure `nfs-server`, you'll be asked for `sudo` password 

###### obs.: Estudos
###
https://github.com/scriptcamp/kubeadm-scripts/blob/main/scripts/master.sh

loadbalancer
https://phcco.com/pt-BR/alta-disponibilidade-e-balanceamento-de-carga-http-com-haproxy.html

https://github.com/justintime/vagrant-haproxy-demo/blob/master/haproxy-setup.sh


deploy multimaster

https://vietkubers.github.io/2019-01-31-ha-cluster-with-kubeadm.html


docker k8s 
https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/

collection

https://github.com/rootritesh/Ansible_Collection_k8s_cluster

config public_network vagrant

https://cursos.alura.com.br/forum/topico-fixar-escolha-de-interface-bridge-no-vagrantfile-93409

k3s
https://github.com/k3s-io/k3s-ansible

deploy k3s
https://www.suse.com/c/rancher_blog/deploying-k3s-with-ansible/


install k8s passo a passo
https://blog.radwell.codes/2021/05/provisioning-single-node-kubernetes-cluster-using-kubeadm-on-ubuntu-20-04/


Set up a Highly Available Kubernetes Cluster using kubeadm
ajudou bastante
https://github.com/justmeandopensource/kubernetes/tree/master/kubeadm-ha-multi-master



Deployment Architecture
https://gist.github.com/sau-lanvy/90819c398972631024a53966132b15bc

Ansible Playbooks To setup cross-datacenters Kubernetes HA (multi-master) on Redhat Enterprise Linux 7.
https://github.com/IBM/ansible-kubernetes-ha-cluster

muito importante para o cluster
https://www.arubacloud.com/tutorial/how-to-create-kubernetes-cluster-with-kubeadm-and-ansible-ubuntu-20-04.aspx

https://medium.com/@baskoro.oktianto/how-to-create-a-high-availability-vanilla-kubernetes-cluster-7e50f0c6f671

https://github.com/digitalvarys/kube-ansible

____

###

 1 - Instalaro virtual box e o vagrant.
 2 - No arquivo, caso nao deseje subir todas as maquinas basta comentar as linhas.
 3 - Repare que para todas as maquinas, alem do ip interno inicializado por 192.168.x.x (dependento da configuracao da sua maquina esse IP pode ser outro) esta configurado para obter um IP da sua rede domestica. Isso foi feito para simular e facilitar alguns acessos.
 4 - Para subir as maquinas basta executar:

 ```
 vagrant up --provision
 ```





###
docker run -d -p 8080:80 -v ~/docker/rancher:/var/lib/rancher --restart=unless-stopped --network=rancher-network --name=rancher-server --privileged rancher/rancher

docker network create rancher-network





