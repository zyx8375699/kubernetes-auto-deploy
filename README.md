# 使用ansible+shell 自动化部署k8s集群(cent os)

一键部署k8s集群, 单master节点，etcd集群。

## 准备工作

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

### /etc/ansible/ansible.cfg

```
[defaults]
inventory      = /app/kubernetes-auto-deploy/hosts    #hosts文件地址
...
roles_path    = /app/kubernetes-auto-deploy/roles:/etc/ansible/roles:/usr/share/ansible/rolesi    #roles文件夹目录
```

### hosts

```
[masters]
master ip
[nodes]
node1 ip
node2 ip
...
[cluster]
master ip
etcd2 ip
etcd3 ip
```

### roles/kube/vars/main.yml

```
docker_private_registry: 10.202.107.19    #私有仓库地址

docker_private_registry_user: admin    #私有仓库登陆用户名

docker_private_registry_password: Zip94303    #私有仓库登陆密码

images_pull_scripts_dir: /app    #下载镜像脚本路径

rpm_dir: /app/kubernetes    #kubernetes安装包路径
```

### roles/node/vars/main.yml

同上

### group_vars/all.yaml

```
master1: 192.168.56.101
master2: 192.168.56.102
master3: 192.168.56.103

etcd:
  etcd1:
    name: etcd1
    ip: 192.168.56.101

  etcd2:
    name: etcd2
    ip: 192.168.56.102

  etcd3:
    name: etcd3
    ip: 192.168.56.103

  cluster:
    name: etcd-cluster    #etcd集群名称

controller_manager:
  cluster_cidr: 10.254.0.0/16    #cluster_cidr

```

## role

- docker: 安装docker并完成docker配置

- sys-cfg: 安装kubernetes前必要的系统配置

- pre: 部署master节点前准备工作

- master1etcd: master1部署

- master2etcd: master2部署

- master3etcd: master3部署

- addon： 安装网络组件

- node: 部署node节点

## 部署k8s

已经安装docker：

```
ansible-playbook etcd_cluster.yaml
```

未安装docker

```
ansible-playbook install_docker.yaml
ansible-playbook etcd_cluster.yaml
```

