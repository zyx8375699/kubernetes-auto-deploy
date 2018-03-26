# ! /bin/sh

kubectl get csr | awk '{print "kubectl certificate approve  " $1}' | sh
