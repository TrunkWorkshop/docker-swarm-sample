cd ../google
make clean-machine

cd ../digitalocean
make clean-machine

make create-machine-keystore
eval $(docker-machine env digitalocean-keystore)
export DOCKER_IP_KEYSTORE=$(docker-machine ip digitalocean-keystore)
make run-consul
make create-machine-swarm-master
make run-sample-server

cd ../google
make create-machine-swarm-node

cd ../digitalocean
eval $(docker-machine env --swarm digitalocean-master)
make create-network-overlay

cd ../digitalocean
make run-sample-server

cd ../google
make run-sample-client

cd ../mix
docker-compose --x-networking --x-network-driver overlay up -d
