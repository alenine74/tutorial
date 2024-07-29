#### basic configs

you can create container with two commands
docker create OR dokcer run
docker create + docker start = docker run

##### name of container 
Docker named the container automaticly 
and randomly by name of image, but you can named it by 
--name arguments.
#### label
you can give some metadata to your container by Lables
this help you to give some data & you can search for container by this labels

#### hostname
you can give your hostname by --hostname when run the container
when run the container by defualt some files and directory are mount to your system
for exampol /etc/hostname mount to /var/lib/docker/container/<container-id>/hostname
you can get your container id by docker inspect
when you arrive to the container you can see the hostname by 
hostname -f OR cat /etc/hostname

#### dns
you can set your desire dns for your container
for example set --dns and give your dns to container
and you can add --dns-search
The --dns-search option in Docker allows you to configure search domains for DNS resolution inside the container. This means that Docker will automatically append these search domains to any hostname that does not have a domain suffix when a DNS query is made from within the container.

#### mac-address
also you can set mac-address by --mac-address 
use this when actually needed

#### mount
you can simply mount file or ... to your container with -v host:container

know if you mount actually you create link and it has read & write permission

notice that if you run your container with read-only

see this two command :

1-  docker run --rm -it --read-only=true -v /home/peyman:/home/ubuntu ubuntu bash :
in this example you can see --read-only, it cause that all file system exept /home/ubuntu 
are read only and the container can write just in this path

2-  docker run --rm -it -v /home/peyman:/home/ubuntu:ro ubuntu bash
in this command just this /home/ubuntu are read only and the container can write every where els 
/home/ubuntu

##### docker info

you can see the docker information
as version and number of container running and something else by this command
docker info
### Implementing Resource Quotas with Docker

Docker provides mechanisms to control and allocate resources to containers using Linux kernel features like cgroups. Here's how you can implement resource quotas in Docker:

#### 1. CPU Constraints

Docker allows you to specify CPU constraints using CPU shares. The concept of CPU shares is Docker's way of allocating CPU resources among containers relative to each other. Here’s an example:

```bash
docker run --rm -ti -c 512 progrium/stress --cpu 2 --timeout 120s
```

- `-c 512`: Allocates 512 CPU shares to the container.
- `--cpu 2`: Runs stress processes on 2 CPUs.

CPU shares are a relative measure; they don’t guarantee a hard limit but influence the scheduling priority of containers. If you allocate more CPU shares to a container, it gets more CPU time when available.

#### 2. CPU Pinning

CPU pinning assigns specific CPU cores to a container. This ensures that a container's processes run only on the designated cores, which can be useful for applications that require consistent CPU performance:

```bash
docker run --rm -ti -c 512 --cpuset=0 progrium/stress --cpu 2 --timeout 120s
```

- `--cpuset=0`: Pins the container to the first CPU core.

#### 3. Memory Constraints

Memory limits in Docker restrict the amount of RAM a container can use. Unlike CPU shares, memory limits are strict:

```bash
docker run --rm -ti -m 512m progrium/stress --cpu 2 --timeout 120s
```

- `-m 512m`: Limits container memory to 512 MB.

Exceeding memory limits can trigger the Linux Out of Memory (OOM) killer, which terminates processes to reclaim memory.

#### 4. Swap Limits

You can set separate swap limits using `--memory-swap`:

```bash
docker run --rm -ti -m 512m --memory-swap=768m progrium/stress --cpu 2 --timeout 120s
```

- `--memory-swap=768m`: Sets memory limit to 512 MB RAM + 256 MB swap.


#### docker stop

you can stop the container from runnint just by docker stop
and you can give them time by -t <time>
if it passed the time and not stop, it kill it.

#### kill container

you can kill them by docker kill,
in this case you send sigterm to them and by --signal=<SIGNALL>
you can send all UNIX signall to container

#### pause container

you can pause container by docker pause and know that if you pause it you can not see any state of your docker
container and if you see docker ps you see that it pause

to continue and run again write docker unpause,

#### docker remove container

docker rm <container id>
dokcer rm $(docker ps -a -q)

and  you can add more filter 
docker rm $(docker ps -a -q --filter 'exited!=0')
#### remove images
docker rmi $(docker images -q)
delete with more options
docker rmi $(docker images -q -f "dangling=true")