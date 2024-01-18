# Groupe de travail pour Wav2Vec en français

## Construisez l'image docker

```shell
docker build \
      --rm \
      --build-arg uid=1018 \
      --build-arg gid=1018 \
      -f Dockerfile.train \
      -t commonvoice-fr .
```

## Lancez un entraînement 

Replace `/mnt/Data_II/Données/STT/data` with the location of your data to be mounted

```shell
docker run \
      -it \
      --gpus=all \
      --privileged \
      --shm-size=1g \
      --ulimit memlock=-1 \
      --ulimit stack=67108864 \
      --mount type=bind,src='/mnt/Data_II/Données/STT/data',dst=/mnt \
      commonvoice-fr && \
    docker container prune || \
    docker container prune -f
```

## Utilisez le shell dans le conteneur

Utiliez `bash` comme point d'entrée en entrant dans le conteneur.

```shell
docker run \
      -it \
      --gpus=all \
      --privileged \
      --shm-size=1g \
      --ulimit memlock=-1 \
      --ulimit stack=67108864 \
      --mount type=bind,src='/mnt/Data_II/Données/STT/data',dst=/mnt \
      --entrypoint bash commonvoice-fr && \
    docker container prune || \
    docker container prune -f
```
