# 使用ansible+shell 自动化部署k8s集群(cent os)

一键部署k8s集群

## 部署方案

简单部署：单master，单etcd

```
git checkout simple
```

etcd集群部署：单master，etcd集群

```
git checkout etcd-cluster
```

高可用方案：

```
git checkout high-availability
```

## 自动化用户创建小工具

配置roles/vars/main.yml

```
ns_name: tool     #namespace 名称

file_dest: /app    #文件存放目录

role_name: admin    #role名称

sa_name: yuxuan     #service account名称

binding_name: admin    #rolebinding名称
```

运行脚本

```
ansible-playbook user.yaml
```