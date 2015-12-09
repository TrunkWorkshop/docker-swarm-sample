make clean-machine

make create-machine-keystore
eval $(docker-machine env google-keystore)
export DOCKER_IP_KEYSTORE=$(docker-machine ip google-keystore)
make run-consul

make create-machine-swarm-master
make create-machine-swarm-node

eval $(docker-machine env --swarm google-master)
make create-network-overlay
make run-sample-server
make run-sample-client

make run-by-compose
