FROM nvidia/vulkan:1.1.121-cuda-10.1-beta.0-ubuntu18.04

# configs
ARG user=carla-docker
ARG passwd=docker
ARG home=/home/$user
ARG ssh_key=id_rsa

# install basic softwares and add user
# prevent interactive input prompts
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A4B469963BF863CC && \
    apt-get update && \
    apt-get install -y xauth zsh git curl glmark2 lsb-release gnupg2 sudo neovim && \
    useradd --create-home -s /bin/bash $user && \
    echo $user:$passwd | chpasswd && \
    adduser $user sudo

# install carla
# prepare environment
RUN apt-get install -y wget software-properties-common && \
    add-apt-repository ppa:ubuntu-toolchain-r/test && \
    wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add - && \
    apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-8 main" && \
    apt-get update && \
    apt-get -y install build-essential clang-8 lld-8 g++-7 cmake ninja-build libvulkan1 python python-pip python-dev python3-dev python3-pip libpng-dev libtiff5-dev libjpeg-dev tzdata sed curl unzip autoconf libtool rsync libxml2-dev git libxrandr2 x11-xserver-utils && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/lib/llvm-8/bin/clang++ 180 && \
    update-alternatives --install /usr/bin/clang clang /usr/lib/llvm-8/bin/clang 180 && \
    pip3 install --upgrade pip && \
    pip install --upgrade pip && \
    pip install --user setuptools distro wheel && \
    pip3 install --user -Iv setuptools==47.3.1 && \
    pip3 install --user distro wheel auditwheel && \
    mkdir /root/.ssh

# Build UnrealEngine
COPY $ssh_key /root/.ssh/$ssh_key
RUN touch /root/.ssh/known_hosts && \
    ssh-keyscan github.com >> /root/.ssh/known_hosts && \
    git clone --depth 1 -b carla git@github.com:CarlaUnreal/UnrealEngine.git $home/UnrealEngine && \
    cd $home/UnrealEngine && \
    ./Setup.sh && ./GenerateProjectFiles.sh && make

# build carla and clean up
RUN cd $home && \
    git clone --depth 1 https://github.com/carla-simulator/carla && \
    ./carla/Update.sh && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /root/.ssh
