sudo apt-get update &&
sudo apt-get install wget software-properties-common &&
sudo add-apt-repository ppa:ubuntu-toolchain-r/test &&
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add - &&
sudo apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-8 main" &&
sudo apt-get update

sudo apt-get -y install build-essential clang-8 lld-8 g++-7 cmake ninja-build libvulkan1 python python-pip python-dev python3-dev python3-pip libpng-dev libtiff5-dev libjpeg-dev tzdata sed curl unzip autoconf libtool rsync libxml2-dev git

sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/lib/llvm-8/bin/clang++ 180 &&
sudo update-alternatives --install /usr/bin/clang clang /usr/lib/llvm-8/bin/clang 180

# update pip
pip3 install --upgrade pip

pip install --upgrade pip

pip install --user setuptools &&
pip3 install --user -Iv setuptools==47.3.1 &&
pip install --user distro &&
pip3 install --user distro &&
pip install --user wheel &&
pip3 install --user wheel auditwheel

# copy ssh file
# clone repo
git clone -b carla --depth 1 git@github.com:CarlaUnreal/UnrealEngine.git
# build
cd UnrealEngine
./Setup.sh && ./GenerateProjectFiles.sh && make

# install vulkan driver and xrandr
sudo apt install libxrandr2 x11-xserver-utils

# test ue4 editor

# build carla
cd ~
git clone --depth 1 https://github.com/carla-simulator/carla
cd carla
./Update.sh
