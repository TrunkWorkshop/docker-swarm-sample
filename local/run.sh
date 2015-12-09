docker-machine rm -f local
docker-machine rm -f swarm-master
docker-machine rm -f swarm-node


docker-machine create -d virtualbox local

eval "$(docker-machine env local)"

export SWARM_TOKEN=$(docker run swarm create)

docker-machine create \
-d virtualbox \
--swarm \
--swarm-master \
--swarm-discovery token://$SWARM_TOKEN \
swarm-master

docker-machine create \
-d virtualbox \
--swarm \
--swarm-discovery token://$SWARM_TOKEN \
swarm-node

eval $(docker-machine env --swarm swarm-master)
docker info
