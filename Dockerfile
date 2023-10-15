FROM osrf/ros:foxy-desktop
#FROM microros/micro-ros-agent:foxy
# System packages 
RUN apt-get update && apt-get -y --quiet --no-install-recommends install \
  apt-utils \
  autoconf \
  automake \
  bison \
  bzip2 \
  build-essential \
  ca-certificates \
  ccache \
  cmake \
  cppcheck \
  curl \
  dmidecode \
  dirmngr \
  dirmngr \
  doxygen \
  file \
  flex \
  g++ \
  genromfs \
  gcc \
  gdb \
  git \
  gnupg2 \         
  gosu \
  gperf \
  lcov \
  libncurses-dev \
  libcunit1-dev \
  libfreetype6-dev \
  libgtest-dev \
  libpng-dev \
  libssl-dev \
  libasio-dev \
  libtinyxml2-dev \
  libtool \ 
  lsb-release \
  make \
  nano \
  ninja-build \
  openjdk-8-jdk \
  openjdk-8-jre \
  openssh-client \
  picocom \
  screen \
  pkg-config \
  python3-dev \
  python3-pip \
  rsync \
  software-properties-common \
  shellcheck \
  tzdata \
  tree \
  uncrustify \
  unzip \
  valgrind \
  vim-common \
  wget \
  xsltproc \
  zip \
  && apt-get -y autoremove \
  && apt-get clean autoclean \
  && rm -rf /var/lib/apt/lists/*
# install some pip packages needed for testing
RUN python3 -m pip install -U \
  argcomplete \
  flake8-blind-except \
  flake8-builtins \
  flake8-class-newline \
  flake8-comprehensions \
  flake8-deprecated \
  flake8-docstrings \
  flake8-import-order \
  flake8-quotes \
  pytest-repeat \
  pytest-rerunfailures \
  pytest
# install Fast-RTPS dependencies
RUN apt install --no-install-recommends -y \
  libasio-dev \
  libtinyxml2-dev
# install Cyclone DDS dependencies
RUN apt install --no-install-recommends -y \
  libcunit1-dev

# install required python packages
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt
RUN rosdep update
COPY install_px4.bash /tmp/install_px4.bash
RUN bash /tmp/install_px4.bash

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
RUN echo "source /opt/ros/foxy/setup.bash" >> /root/.bashrc


# # install java_home
RUN apt-get update && apt-get install -y \
  openjdk-11-jdk \
  && rm -rf /var/lib/apt/lists/*

RUN echo "JAVA_HOME=\"/usr/lib/jvm/java-11-openjdk-amd64\"" >> /etc/environment

# FAST RTPS Gen
RUN pip3 install -U empy pyros-genmsg setuptools
RUN git clone --recursive https://github.com/eProsima/Fast-DDS-Gen.git -b v1.0.4 /tmp/Fast-DDS-Gen
COPY install_fastrtpsgen.bash /tmp/install_fastrtpsgen.bash
RUN bash /tmp/install_fastrtpsgen.bash

# default workspace
RUN mkdir -p /home/ubuntu/robot_ws/src
WORKDIR /home/ubuntu/robot_ws
# CMD ["/bin/bash"]

# install ros2-px4 bridge

COPY download_px4ros_rtps.bash /home/ubuntu/download_px4ros_rtps.bash
COPY download_px4_autopilot.bash /home/ubuntu/download_px4_autopilot.bash

#PX4_Autopilot - 30150f723a69068d12de9295b5d7e1e4fdbf4677


# documentation(https://docs.px4.io/main/en/ros/ros2_comm.html) for setting up PX4 RTPS-ROS2 (Nov.10.22),

# use these commits for the following repos:

# PX4_Auto~ : 30150f723a69068d12de9295b5d7e1e4fdbf4677

# PX4_msg: https://github.com/PX4/px4_msgs/tree/daee1217b8834cb5293f7913bd7f0850c882ffb7

# PX4_ros_com: https://github.com/PX4/px4_ros_com/tree/7e25c34df0aab25d6e723385322c62712ea97207
