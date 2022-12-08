#!/bin/bash

exportfs -a
rpcbind
rpc.statd
rpc.nfsd

exec rpc.mountd --foreground