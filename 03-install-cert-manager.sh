kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.1/cert-manager.yaml

echo "Waiting until all cert-manager pods are started ..."
while true; do
    if kubectl get ns cert-manager &> /dev/null; then
        not_running_pods=$(kubectl get pods -n cert-manager | grep -v "STATUS\|Running" | wc -l)
        running_pods=$(kubectl get pods -n cert-manager | grep "Running" | wc -l)
        printf "Running Pods: $running_pods / $((not_running_pods + running_pods))\r"
        if [ $not_running_pods -eq 0 ]; then
            break
        fi
    fi
    sleep 5
done
sleep 5

oc create -f - <<EOF
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: rhcs-issuer-user
spec:
  selfSigned: {}
EOF

oc create -f - <<EOF
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: rhcs-issuer-server
spec:
  selfSigned: {}
EOF