# NFS container using Centos

## build

### NFS Server container image

`docker build -t nfs_keysign:0.0.1 -f Dockerfile.nfs .`

### NFS client container image

#### IBM jdk based image container

enter into directory: `nfs_cli_container_image/ibmjavasdk_based`

run 

`docker build -t nfs_cli_ibmjava:8-sdk -f Dockerfiles_nfs_cli_ibmjavasdk .`


#### privileged flag

container server or client must run on privileged mode

```
  nfs-service:
    container_name: nfs_service
    image: nfs_keysign:0.0.1
    privileged: true
    ports:
      - 111:111
      - 2049:2049
	  - 20048:20048
#    volumes:
#      - ./nfs_dir:/var/nfsshare
```
client:
```
docker run --privileged -it --name cli_centos \
  --network ss_db_default \
  centos_nettols_telnet:centos8.3.2011
```

### test container

get into the container and exec command:

`showmount -e`

example:

```
[root@4cecf74d6ae0 /]# showmount -e
Export list for 4cecf74d6ae0:
/var/nfsshare keysign_service

```

command for installing netstat, telnet in nfs centos

```
yum install net-tools -y
yum install telnet -y
```

### Ubuntu client 


do:  

```bash
### install parts
apt-get update
apt-get install -y nfs-common netbase


### exec nfs rpcbind parts
update-rc.d rpcbind enable
update-rc.d nfs-common enable
service rpcbind restart
service nfs-common start


### mount 
mkdir /mnt/tes
mount nfs_service:/var/nfsshare /mnt/tes

### other mount options
mount -vvvv -t nfs -o vers=3 nfs_service:/var/nfsshare /mnt/tes
mount -vvvv -t nfs -o nolock nfs_service:/var/nfsshare /mnt/tes
```

**install ping util**

`apt install iputils-ping`

or 

`apt install inetutils-ping`

seems *inetutils-ping* is more compatible for nfs client implementation 

**install telnet**

`apt-get install telnet`

### Centos client 

worked with -o nolock option or `rpc*` started 

```
##yum -y install initscripts
yum -y install nfs-utils

#exportfs -a&
rpcbind&
rpc.statd&
rpc.nfsd&

exec rpc.mountd --foreground&

mkdir /mnt/tes
mount -vvvv nfs_service:/var/nfsshare /mnt/tes/
mount -vvvv -t nfs nfs_service:/var/nfsshare /mnt/tes/
mount -vvvv -o vers=3 -t nfs nfs_service:/var/nfsshare /mnt/tes/

mount -vvvv -t nfs -o nolock nfs_service:/var/nfsshare /mnt/tes
```


#### ref

 - https://github.com/rancher/os/issues/1314
 - https://github.com/rancher/os/issues/1601
 - https://github.com/mnagy/nfs-server
 - https://www.youtube.com/watch?v=c3dL0ULEH-s
 - https://github.com/ErezHorev/dockerized_nfs_server
 - https://unix.stackexchange.com/questions/466999/what-does-exec-do
 