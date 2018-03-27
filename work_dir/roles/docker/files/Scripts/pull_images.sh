#!/bin/bash
 
ARCH=amd64
version=v1.9.3
#username=fanlz
 
#https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init/#config-file
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
	#docker tag ${username}/${image} k8s.gcr.io/${image}
	docker tag 10.202.107.19/kubernetes/${image} gcr.io/google_containers/${image}
	#docker push 10.202.107.19/kubernetes/${image}
	docker rmi 10.202.107.19/kubernetes/${image}
done
 
unset ARCH version images username
