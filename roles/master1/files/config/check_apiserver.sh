 #!/bin/sh

 errorExit() {
     echo "*** $*" 1>&2
     exit 1
 }

 curl --silent --max-time 2 --insecure https://localhost:6443/ -o /dev/null || errorExit "Error GET https://localhost:6443/"
 #if ip addr | grep -q 10.203.12.57; then
 #    curl --silent --max-time 2 --insecure https://10.203.12.57:6443/ -o /dev/null || errorExit "Error GET https://10.203.12.57:6443/"
 #fi
