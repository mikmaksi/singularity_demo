FROM ubuntu:16.04

# update package manager
RUN apt-get update

# make sane environment
RUN apt-get install -qqy \
    apt-utils build-essential pkg-config \
    unzip git automake

# other Singularity build dependencies
RUN apt-get install -y libtool libarchive-dev squashfs-tools

# need to run rerun apt-get update installing python
RUN apt-get update
RUN apt-get install -y python vim

# install Singularity
WORKDIR /home
RUN git clone -b vault/release-2.5 https://github.com/sylabs/singularity/
WORKDIR singularity
RUN ./autogen.sh
RUN ./configure
RUN make
RUN make install

# adduser so that if we create files inside docker we can change their ownership
ARG user
ARG uid
RUN useradd -r -u $uid $user

WORKDIR /home
CMD ["/bin/bash"]
