--no-cache ==> for docker images , when want to rebuild image is it so good to use --no-cache
be cause in this case build it as first and with no cashe

#### mirror registry images
this is so good to use mirror
in this case you mirror some registry to your registry
and when you pull some images from your registry if your wanted not exist it get it from the mirror registry 
and use from it.

if you delete image and pull it again, you pull it faster than first one, you can measure it by "time docker pull <image name>"

#### history of containers

first use chroot command to isolated
filesystems
after that use jail command to use
isolated environment
and after all use Zones and then create container by LXC
and after all in 2013, Docker comes



