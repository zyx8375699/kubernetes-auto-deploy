# ! /bin/sh

kubectl get csr | awk '$2~/m/' | awk '{print "kubectl certificate approve  " $1}' | sh
