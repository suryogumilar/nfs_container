#!/bin/bash

## code from : https://github.com/ErezHorev/dockerized_nfs_server/blob/master/docker/run.sh

## Set –e is used within the Bash to stop execution instantly 
## as a query exits while having a non-zero status. 
## This function is also used when you need to know the 
## error location in the running code
set -e

### Handle `docker stop` for graceful shutdown
function shutdown {
    echo "- Shutting down container.."
    service service nfs-common start stop
    echo "- Nfs comon service is is down"
    exit 0
}

trap "shutdown" SIGTERM

update-rc.d rpcbind enable
update-rc.d nfs-common enable
service rpcbind start
service nfs-common start

echo "- Nfs client is up and running.."




## from https://unix.stackexchange.com/questions/466999/what-does-exec-do
##The "$@" bit will expand to the list of positional parameters (usually the command line arguments), individually quoted to avoid word splitting and filename generation ("globbing").

##The exec will replace the current process with the process resulting from executing its argument.

##In short, exec "$@" will run the command given by the command line parameters in such a way that the current process is replaced by it (if the exec is able to execute the command at all).

#exec "$@"

#echo "args: $@"

if [ -z "$@" ]
then
    ## Run forever
    sleep infinity    
else
    echo "execute $@"
    exec "$@"
fi
