clean-machine:
	- docker-machine rm -f digitalocean-master
	- docker-machine rm -f digitalocean-node
	- docker-machine rm -f digitalocean-keystore

create-machine-keystore:
	docker-machine create \
    --driver digitalocean \
		--digitalocean-image ubuntu-15-10-x64 \
    digitalocean-keystore

run-consul:
	docker run -d \
	  -p "8500:8500" \
	  -h "consul" \
	  progrium/consul -server -bootstrap

create-machine-swarm-master:
	docker-machine create \
		--driver digitalocean \
		--digitalocean-image ubuntu-15-10-x64 \
		--swarm --swarm-image="swarm" --swarm-master \
		--swarm-discovery="consul://$(DOCKER_IP_KEYSTORE):8500" \
		--engine-opt="cluster-store=consul://$(DOCKER_IP_KEYSTORE):8500" \
		--engine-opt="cluster-advertise=eth0:2376" \
		digitalocean-master

create-machine-swarm-node:
	docker-machine create \
	--driver digitalocean \
	--digitalocean-image ubuntu-15-10-x64 \
	--swarm --swarm-image="swarm" \
	--swarm-discovery="consul://$(DOCKER_IP_KEYSTORE):8500" \
	--engine-opt="cluster-store=consul://$(DOCKER_IP_KEYSTORE):8500" \
	--engine-opt="cluster-advertise=eth0:2376" \
	digitalocean-node

create-network-overlay:
	docker network create --driver overlay cloud-overlay

run-sample-server:
	docker run -itd --name=web --net=cloud-overlay --env="constraint:node==digitalocean-master" nginx

run-sample-client:
	docker run -it --rm --net=cloud-overlay --env="constraint:node==digitalocean-node" busybox wget -O- http://web

run-by-compose:
	docker-compose --x-networking --x-network-driver overlay up -d
