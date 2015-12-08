clean-machine:
	- docker-machine rm -f google-master
	- docker-machine rm -f google-node
	- docker-machine rm -f google-keystore

create-machine-keystore:
	docker-machine create \
    --driver google \
		--google-machine-type f1-micro \
    google-keystore

run-consul:
	docker run -d \
	  -p "8500:8500" \
	  -h "consul" \
	  progrium/consul -server -bootstrap

create-machine-swarm-master:
	docker-machine create \
		--driver google \
		--google-machine-type f1-micro \
		--swarm --swarm-image="swarm" --swarm-master \
		--swarm-discovery="consul://$(DOCKER_IP_KEYSTORE):8500" \
		--engine-opt="cluster-store=consul://$(DOCKER_IP_KEYSTORE):8500" \
		--engine-opt="cluster-advertise=eth0:2376" \
		google-master

create-machine-swarm-node:
	docker-machine create \
	--driver google \
	--google-machine-type f1-micro \
	--swarm --swarm-image="swarm" \
	--swarm-discovery="consul://$(DOCKER_IP_KEYSTORE):8500" \
	--engine-opt="cluster-store=consul://$(DOCKER_IP_KEYSTORE):8500" \
	--engine-opt="cluster-advertise=eth0:2376" \
	google-node

create-network-overlay:
	docker network create --driver overlay cloud-overlay

run-sample-server:
	docker run -itd --name=web --net=cloud-overlay --env="constraint:node==google-master" nginx

run-sample-client:
	docker run -it --rm --net=cloud-overlay --env="constraint:node==google-node" busybox wget -O- http://web

run-by-compose:
	docker-compose --x-networking --x-network-driver overlay up -d
