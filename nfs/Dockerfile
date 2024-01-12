# Use Alpine Linux as the base image
FROM alpine:latest

# Cambiar el shell predeterminado a /bin/sh
SHELL ["/bin/sh", "-c"]

# Install NFS utilities
RUN apk --no-cache add nfs-utils rpcbind

# Create the directory that will be shared
RUN mkdir -p /mnt/nfs_share && chmod -R 777 /mnt/nfs_share

# Create the NFS exports file
RUN echo "/mnt/nfs_share *(rw,sync,no_subtree_check,no_root_squash,insecure,fsid=0)" > /etc/exports

# Expose the NFS ports for both NFSv3 and NFSv4
EXPOSE 2049/tcp 111/tcp 111/udp

# Start the NFS server and RPCBIND
CMD ["sh", "-c", "while true; do rpcbind; exportfs -ra; rpc.nfsd -N 3 -N 4.1 -N 4.2; rpc.mountd -N 3 -N 4.1 -N 4.2; sleep 30; done"]