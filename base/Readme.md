# ubuntu-turbovnc

This is a container TurboVNC and Ubuntu XFCE desktop.

First, get the image by cloning this repository and building it:
```
docker build -t mxcar:base .
```

Then, run it:
```
docker run -ti --network="host" mxcar:base
```

Create a permanent container
```
docker create --name mxcar-base  --hostname=mxcar-base --interactive  --network="host"  mxcar:base
docker container start mxcar-base
docker container exec -it mxcar-base bash
```
