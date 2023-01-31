# carla-docker-gui

Docker image and docker-compose files used to build and launch a Carla container with GUI support. Tested with archlinux.

## Usage

### Preparations

This project use [docker](https://www.docker.com/) and [docker-compose](https://docs.docker.com/compose/) to work, make sure you install them before going any further. To leverage Nvidia GPU, you need to install [nvidia-container-toolkit](https://github.com/NVIDIA/nvidia-container-toolkit). For arch user, run

```bash
yay -S docker docker-compose nvidia-container-toolkit
# add user to docker group to get access to docker
sudo usermod -aG docker <user>
# reboot your device
```



Make sure that you have access to unreal engine codes in Github, see
[here](https://www.unrealengine.com/en-US/ue4-on-github) for instruction to get access. After getting access, clone both Carla and UE4 project from Github.

**Note: These two folders will be very large, prepare at least 120 GB for them**

```bash
git clone -b carla --depth 1 git@github.com:CarlaUnreal/UnrealEngine.git
git clone --depth 1 https://github.com/carla-simulator/carla
```

### Build

Build the image for compile environment.

```bash
docker-compose build
```

### Edit `.env` file

Copy the `.env.example` file to `.env` and edit the variables if required

```bash
cp .env.example .env
---------------
DOCKER_HOME=/home/carla
# specify UE4_PATH and CARLA_PATH to map
UE4_PATH=./UnrealEngine
CARLA_PATH=./carla
```

### Compile and Run

Run the following command to start compilation and launch the UE4 editor. The compilation will take a long time (several hours). After first compilation, the program should start quite fast (~1 minute).
```bash
docker-compose up
```



# Tips on using `docker-compose`

To shut down the device, 

```bash
docker-compose down
```

To restart the service, 

```bash
docker-compose restart
```

