docker build -t friendou/fibonacci-client:latest -t friendou/fibonacci-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t friendou/fibonacci-server:latest -t friendou/fibonacci-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t friendou/fibonacci-worker:latest -t friendou/fibonacci-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push friendou/fibonacci-client:latest
docker push friendou/fibonacci-server:latest
docker push friendou/fibonacci-worker:latest

docker push friendou/fibonacci-client:$GIT_SHA
docker push friendou/fibonacci-server:$GIT_SHA
docker push friendou/fibonacci-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=friendou/fibonacci-server:$GIT_SHA
kubectl set image deployment/client-deployment client=friendou/fibonacci-client:$GIT_SHA
kubectl set image deployment/worker-deployment worker=friendou/fibonacci-worker:$GIT_SHA
