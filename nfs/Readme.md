# servidor nfs en docker

## Crear un servidor nfs a partir de una imagen de docker

```bash
docker run -d  --privileged -v ./nfs:/mnt/nfs_share -p 2049:2049 nfshome
```

##  probar el servidor nfs utiliando como cliente nginx

```bash
docker compose up -d
```

## crea el archivo index.html en el directorio nfs

```bash
echo "hola mundo" > ./nfs/index.html
```

## acceder a la pagina web

```bash
curl localhost:8870
```


# disponibilizar el servidor nfs a k3s local

## crear el archivo de configuracion del servidor nfs

```bash
# volume class  for nfs
cat <<EOF | kubectl apply -f -
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: nfs
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
EOF
```

## crear el archivo de configuracion del servidor nfs

```bash
# persistent volume claim for nfs
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: nfs
spec:
  accessModes:
    - ReadWriteMany
  storageClassName: nfs
  resources:
    requests:
      storage: 1Mi
EOF

```

## crear el archivo de configuracion del servidor nfs

```bash
# persistent volume for nfs
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nfs
spec:
    capacity:
        storage: 1Mi
    accessModes:
        - ReadWriteMany
    persistentVolumeReclaimPolicy: Retain
    storageClassName: nfs
    nfs:
        path: /mnt/nfs_share
        server: localhost
EOF
```

## crear el archivo de configuracion del servidor nfs

```bash
# deployment for nginx
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
spec:
    replicas: 1
    selector:
        matchLabels:
        app: nginx
    template:
        metadata:
        labels:
            app: nginx
            tier: frontend
        spec:
        containers:
        - name: nginx
            image: nginx
            ports:
            - containerPort: 80
            volumeMounts:
            - mountPath: "/usr/share/nginx/html"
            name: nfs
        volumes:
        - name: nfs
            persistentVolumeClaim:
            claimName: nfs
EOF
```


###############

# mas simple utilizando el aprovisionador de nfs helm

## instalar el aprovisionador de nfs

```bash
helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=192.168.100.21 \
    --set nfs.path=/mnt/nfs_share \
    --set storageClass.name=nfs \
    --set nfs.mountOptions[0]="vers=4.2" \
    --namespace nfs

```

## crear el archivo de configuracion del servidor nfs

```bash
# deployment for nginx
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
spec:
    replicas: 1
    selector:
        matchLabels:
        app: nginx
    template:
        metadata:
        labels:
            app: nginx
            tier: frontend
        spec:
        containers:
        - name: nginx
            image: nginx
            ports:
            - containerPort: 80
            volumeMounts:
            - mountPath: "/usr/share/nginx/html"
            name: nfs
        volumes:
        - name: nfs
            persistentVolumeClaim:
            claimName: nfs
EOF
```

## crea el archivo index.html en el directorio nfs

```bash
echo "hola mundo" > ./nfs/index.html
```
