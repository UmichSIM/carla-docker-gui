# carla-docker-gui

Dockerfile used to build a Carla container with GUI support.

## Usage

### Setting up ssh key

Make sure that you have access to unreal engine codes in github, see
[here](https://www.unrealengine.com/en-US/ue4-on-github) for instruction to get access. After getting access, place your ssh key into the project directory and rename it to `id_rsa`. The codes will be downloaded automatically during build process.

**IMPORTANT NOTE:** don't  share this image to others since your key file will be kept in the history.

### Build

After setting up your ssh key, run the following command to build the image.

```bash
docker built -t carla-docker-gui .
```

### Run

Create the container using the following command.

```bash
docker run -itd \
         -e DISPLAY \
         --gpus all \
         --user=`id -u`:`id -g` \
         -v /tmp/.X11-unix/:/tmp/.X11-unix/  \
         --privileged \
         --network host \
         --name carla-gui carla-docker-gui
```

Attach to shell

```bash
docker exec -it carla-gui bash
```
