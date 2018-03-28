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

## 待开发

- 一键系统配置

- 自动化用户创建工具