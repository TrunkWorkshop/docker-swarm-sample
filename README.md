Docker Swarm Sample
===================

google sample
-------------

### login gcloud

`gcloud auth login`: https://cloud.google.com/sdk/

### create google-project

export GOOGLE_PROJECT='docker-0000'

### activate Compute Engine API

setup on GCP dashboard

### setup firewall-rules

```
gcloud compute firewall-rules update default-swarm --allow tcp:2376 tcp:2375 tcp:3376 tcp:8500 UDP:4789 TCP:7946 UDP:7946 --source-range 0.0.0.0/0
gcloud compute firewall-rules create default-demo --allow tcp:5000 tcp:27017 tcp:80 --source-range 0.0.0.0/0
```

digitalocean sample
-------------------

### setup token

```
export DIGITALOCEAN_ACCESS_TOKEN=123456
```
