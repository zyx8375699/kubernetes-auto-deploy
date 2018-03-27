#!/bin/bash
 
ARCH=amd64
version=v1.9.3 

images=(kube-apiserver-${ARCH}:${version} \
	kube-controller-manager-${ARCH}:${version} \
	kube-scheduler-${ARCH}:${version} \
	kube-proxy-${ARCH}:${version} \
	etcd-${ARCH}:3.1.11 \
	pause-${ARCH}:3.0 \
	k8s-dns-sidecar-${ARCH}:1.14.7 \
	k8s-dns-kube-dns-${ARCH}:1.14.7 \
	k8s-dns-dnsmasq-nanny-${ARCH}:1.14.7 \
	)
 
for image in ${images[@]}
do
	docker pull 10.202.107.19/kubernetes/${image}
	docker tag 10.202.107.19/kubernetes/${image} gcr.io/google_containers/${image}
	docker rmi 10.202.107.19/kubernetes/${image}
done
 
unset ARCH version images username
docker pull 10.202.107.19/kubernetes/quay.io/coreos/flannel:v0.10.0-amd64
docker tag 10.202.107.19/kubernetes/quay.io/coreos/flannel:v0.10.0-amd64 quay.io/coreos/flannel:v0.10.0-amd64
docker rmi 10.202.107.19/kubernetes/quay.io/coreos/flannel:v0.10.0-amd64
