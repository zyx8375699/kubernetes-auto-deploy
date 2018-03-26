#! /bin/sh

systemctl daemon-reload
systemctl stop kubelet
docker rm -f $(docker ps -aq)
rm -rf /var/lib/kubelet/*
rm -rf /var/lib/etcd/*
