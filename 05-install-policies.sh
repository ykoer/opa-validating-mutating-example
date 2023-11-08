opa build -b policies -o policies/bundle.tar.gz
docker rm bundle-server --force
docker run --rm --name bundle-server -d -p 8888:80 -v ${PWD}/policies:/usr/share/nginx/html:ro nginx:latest

kubectl rollout restart deployment opa -n opa

while [[ $(kubectl get pods -n opa | grep -v "STATUS\|Running" | wc -l) -ne 0 ]]; do
    sleep 2
done