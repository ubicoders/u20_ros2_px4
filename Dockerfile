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
RUN echo "alias python=python3" >> /root/.bashrc


# default workspace
RUN mkdir -p /home/ubuntu/robot_ws/src
WORKDIR /home/ubuntu/robot_ws

COPY download_px4_autopilot.bash /home/ubuntu/download_px4_autopilot.bash
COPY download_bridge_px4_ros.bash /home/ubuntu/
COPY install_uxrce.bash /home/ubuntu/install_uxrce.bash

COPY ./requirements.txt /home/ubuntu/requirements.txt
RUN pip install -r /home/ubuntu/requirements.txt
RUN pip3 install -r /home/ubuntu/requirements.txt
RUN rm -r /home/ubuntu/requirements.txt

RUN apt-get install python3-tk -y

# # Install miniconda to /miniconda
# RUN curl -LO http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
# RUN bash Miniconda3-latest-Linux-x86_64.sh -p /miniconda -b
# RUN rm Miniconda3-latest-Linux-x86_64.sh
# ENV PATH=/miniconda/bin:${PATH}
# RUN conda update -y conda
# RUN conda install -c anaconda -y python=3.11.0
# RUN conda install -c anaconda  conda-build
# RUN conda init bash
