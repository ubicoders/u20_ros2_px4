#===============================================================================
# ROS2 Development Environment
#===============================================================================

FROM osrf/ros:foxy-desktop

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

# conda
RUN curl -LO http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash Miniconda3-latest-Linux-x86_64.sh -p /miniconda -b
RUN rm Miniconda3-latest-Linux-x86_64.sh
ENV PATH=/miniconda/bin:${PATH}
RUN conda init

# install required python packages
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt
RUN rosdep update

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
RUN echo "source /opt/ros/foxy/setup.bash" >> /root/.bashrc

# default workspace
RUN mkdir -p /home/ubuntu/robot_ws/src
WORKDIR /home/ubuntu

#===============================================================================
# PX4 Development Environment
#===============================================================================
# Install PX4 toolchain
COPY install_px4_env.bash /tmp/install_px4_env.bash
RUN bash /tmp/install_px4_env.bash

# PX4 and MavLink Downloader
COPY download_px4_mavlink.bash /home/ubuntu/download_px4_mavlink.bash
