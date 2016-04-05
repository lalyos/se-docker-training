This is the repo of the docker/cloudbreak training for the SE guys, held in 2016.04.

# Day 1.

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

## Election excercise

Imagine, you are running for the election, and want to create a supporting website. Later you
might want to sell (i mean make it opensource available to others) the 'website as a service'.

## Basics

```
# try diff flavors of linux
docker run -it debian
docker run -it centos
docker run it alpine sh

# docker pull is optional

# detach
CTRL-P followed by CTRL-Q

# isnpect metadata:
docker insect $(docker ps -ql)

# whats runninig in conatiener:
docker top

# attach back to latest:
docker attach $(docker ps -ql)

# give a name to the container after its started
docker rename $(docker ps -ql) whatever

# give a name while starting:
docker run -d --name no-silly-name debian
```
### Image by hand

We do the first steps inside from the VM, just to avoid setting DOCKER_XXX env vars,
and not worrining abour reaching container by internal IP/ports.

```
boot2docker ssh
docker-machine ssh
```

Once in the VM:
```
docker run -it --name web alpine sh

apk add -U nginx
nginx

# detach from the container
CTRL-P CTRL-Q
```

Now from docker host you can reach the deafult web page
```
docker inspect  web | grep IPA
curl 172.17.0.X
```

Or a bit longer but get only get the exact json part:
```
curl $(docker inspect -f '{{.NetworkSettings.IPAddress}}'  web)
```

Usefull alias for getting the last IP
```
alias lastip="docker inspect -f '{{json .NetworkSettings.IPAddress}}' $(docker ps -ql)"
```

Modify the index.html by hand:

```
docker attach web
echo myself for president > /usr/share/nginx/html/index.html
```

Check the new web page:
```
# detach ctrl-p ctrl-q
curl $(docker inspect -f '{{.NetworkSettings.IPAddress}}'  web)
```

create an image from a container:
```
docker commit web election
```

delete all container, and than start a new container from the image
```
# clean
alias docker-kill-all='docker rm -f $(docker ps -qa)'
docker-killall

docker run -d election nginx
```

Hmm he container is nor running?! Try to figure out why?

Start it by "cheating"

```
docker run -d election sh -c "nginx; sleep 1000"
```

start nginx in the foreground:

```
docker run -d election nginx -g 'daemon off;'
```

# day 2

## docker log

Start a container priniting the date each second:

```
docker run -d alpine sh -c 'while true; do date; sleep 1; done'
```

Exercice: Make docker logs useful with the election image

Make ngingx run in the background again, and print the access log to the stdout.
(Solution is tagged: git checkout logging)

Build and run the new image
```
docker run -d --name election -p 8080:80 elec
docker logs -f election
```

refresh in the browser: http://b2d:8080, and whach the console.



## volumes




- (volume drivers)

## Service discovery

Start autoregistration magic:
```
# start consul
docker run -d \
  -p 8500:8500 \
  -p 0.0.0.0:53:8600/udp \
  gliderlabs/consul-server:0.5\
    -bootstrap  --advertise 192.168.59.103  -recursor 8.8.8.8

# start registrator
docker run -d \
  -v /var/run/docker.sock:/tmp/docker.sock \
  --privileged gliderlabs/registrator:v5 \
    consul://192.168.59.103:8500
```

Start a container wich get registered:

```
docker run -d \
   -p 80:80 -e SERVICE_NAME=web nginx
```
## docker-compose


##

