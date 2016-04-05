This is the repo of the docker/cloudbreak training for the SE guys, held in 2016.04.

# day 1.

## Installation:

Docker need linux, so if you are using linux already: `curl -L https://get.docker.com | sh`

If you are using osx, You have to create a VirtualBox VM which will run a 
docker tailored tiny core linux. You can create it with either `boot2docker` or `docker-machine`
(the use the same boot disk anyway)

Most of the time the 2 commands `boot2docker` and `docker-machine` are interchangebla.

## OSX install docker - cli way

```
brew install boot2docker
brew install docker
```

Create the VM with enough memory/disk:
```
## boot2docker
boot2docker -m 8192 -s 3000

## docker-machine
docker-machine create --driver virtualbox --virtualbox-memory 8192 --virtualbox-disk-size 30000 docker-training
```

You need 3 environment variable so that docker cli can talk to docker daemon:
```
## b2d
eval "$(boot2docker shellinit)"

## docker-machine
eval "$(docker-machine env)"
```

## OSX install docker - gui way

Go download/install: [toolbox](https://www.docker.com/products/docker-toolbox)
##

Usage:
```
docker run -d \
  -e PRESIDENT=$USER -p 8080:80  lalyos/elec:v2
```
