# 使用ansible+shell 自动化部署k8s集群(cent os)

一键部署k8s集群, 单master节点，etcd集群。

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
master ip
[nodes]
node1 ip
node2 ip
...
[cluster]
master ip
node1 ip
node2 ip
...
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

### 脚本，部署yaml文件

存放在不同roles的files/Scripts和files/manifests目录下，根据之前教程修改内容

## role

- docker: 安装docker并完成docker配置

- kube: 部署master节点

- addon： 安装网络组件

- node: 部署node节点

## 部署k8s

已经安装docker：

```
ansible-playbook install_whole.yaml
```

未安装docker

```
ansible-playbook install_docker.yaml
ansible-playbook install_whole.yaml
```

## pending

- 高可用k8s集群搭建

- 服务自动部署