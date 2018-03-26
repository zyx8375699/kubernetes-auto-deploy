#! /bin/sh

export KUBE_APISERVER="https://192.168.56.200:443"

cat <<EOF > kube-proxy-csr.json
{
    "CN": "system:kube-proxy",
    "key": {
        "algo": "rsa",
        "size": 2048
    },
    "names": [
        {
            "C": "CN",
            "ST": "GuangDong",
            "L": "ShenZhen",
            "O": "system:kube-proxy",
            "OU": "sfai"
        }
    ]
}
EOF

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -profile=kubernetes \
  kube-proxy-csr.json | cfssljson -bare kube-proxy

# kube-proxy set-cluster
kubectl config set-cluster kubernetes \
    --certificate-authority=ca.pem \
    --embed-certs=true \
    --server=${KUBE_APISERVER} \
    --kubeconfig=../kube-proxy.conf

# kube-proxy set-credentials
 kubectl config set-credentials system:kube-proxy \
    --client-key=kube-proxy-key.pem \
    --client-certificate=kube-proxy.pem \
    --embed-certs=true \
    --kubeconfig=../kube-proxy.conf

# kube-proxy set-context
kubectl config set-context system:kube-proxy@kubernetes \
    --cluster=kubernetes \
    --user=system:kube-proxy \
    --kubeconfig=../kube-proxy.conf

# kube-proxy set default context
kubectl config use-context system:kube-proxy@kubernetes \
    --kubeconfig=../kube-proxy.conf

#clush -a "mkdir -p /etc/kubernetes/pki"
#clush -a -c kube-proxy.pem kube-proxy-key.pem --dest /etc/kubernetes/pki
#clush -a -c ../kube-proxy.conf --dest /etc/kubernetes
