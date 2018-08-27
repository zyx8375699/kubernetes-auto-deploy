# 使用ansible + shell脚本自动化部署k8s高可用集群(cent os)

一键部署k8s集群，需要在master节点执行

## 准备工作

完成k8s裸搭文档中的系统配置工作。

安装ansible

```
yum install -y epel-release
yum install -y ansible
```

如果需要自动docker认证private registry还需要安装docker-py

```
yum install -y python-pip
pip install docker-py
```

## 修改文件

### hosts

```
[masters]
master1 ip
master2 ip
master3 ip
[nodes]
node1 ip
node2 ip
...
[cluster]
master1 ip
master2 ip
master3 ip
node1 ip
node2 ip
...
```

## role

- docker: 安装docker并完成docker配置；

- pre: 部署master节点之前所做准备工作，如拉取镜像、安装kubelet、创建kubernetes文件夹等；

- master1: keepalived Master节点，master1节点stand-alone模式启动，包括创建CA证书，创建部署yaml文件，以stand-alone模式启动kubelet；

- master2full: keepalived Backup节点，master2节点stand-alone模式启动，包括拷贝证书，创建部署yaml文件，以stand-alone模式启动kubelet；

- master3full: master节点，master3节点stand-alone模式启动，包括拷贝证书，创建部署yaml文件，以stand-alone模式启动kubelet；

- master-join: 将所有master节点加入kubernetes集群；

- addon：安装网络组件kube-proxy，flannel，kube-dns；

- node: 部署node节点

## 部署前配置修改

### role/docker/vars/main.yml

```
docker_dir: /app/var/lib/docker     #docker目录地址
```

### roles/pre/vars/main.yml

```
docker_private_registry: 10.202.107.19    #私有仓库地址

docker_private_registry_user: admin    #私有仓库登陆用户名

docker_private_registry_password: Zip94303    #私有仓库登陆密码

images_pull_scripts_dir: /app    #下载镜像脚本路径

rpm_dir: /app/kubernetes    #kubernetes安装包路径

etcd_dir: /app/var/lib/etcd    #etcd储存地址

etcd_volume_mount: true    #etcd储存是否需要挂载
```

### roles/master1/vars/main.yml

```
haproxy_dir: /app/Install/haproxy    #haproxy地址

keepalived_dir: /app/Install/keepalived    #keepalived地址
```

### roles/master2full/vars/main.yml

同上

### roles/master3full/vars/main.yml

同上

### roles/nodes/vars/main.yml

```
master1: 192.168.56.101    #执行kubectl的机器名称
```

### roles/nodes/vars/main.yml

同pre和master-join

### 脚本，部署yaml文件， haproxy, keepalived配置文件

存放在不同roles的files目录下，根据之前教程修改内容，后续考虑单独写出一个变量文件。

## 部署k8s

在work_dir下，

已经安装docker：

```
ansible-playbook ha_cluster.yaml
```

未安装docker

```
ansible-playbook install_docker.yaml
ansible-playbook ha_cluster.yaml
```

或者分role执行，防止中间出现问题

## pending

- 使用ansible进行系统配置

- 服务自动部署
