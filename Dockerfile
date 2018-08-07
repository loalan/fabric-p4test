FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y git python-pip lsb-release
RUN apt-get install -y sudo && rm -rf /var/lib/apt/lists/*

# Install
RUN git clone https://github.com/opennetworkinglab/onos.git /onos
ENV ONOS_ROOT=/onos

RUN bash $ONOS_ROOT/tools/dev/p4vm/install-p4-tools.sh
RUN cd ~/p4tools/bmv2/tools && bash veth_setup.sh

COPY . /src/
WORKDIR /src/tests/ptf
RUN make fabric
