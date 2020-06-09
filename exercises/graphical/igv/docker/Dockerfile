FROM ubuntu:18.04

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

ARG LC_ALL="C"
ENV DEBIAN_FRONTEND="noninteractive" \
    LC_ALL="${LC_ALL}"
RUN apt-get update && apt-get install -y --no-install-recommends \
    default-jre \
    xauth \
    unzip \
    vim \
    wget \
  && apt-get clean all && \
  apt-get purge && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG IGV_VER="2.8.3"
RUN mkdir /apps && cd /apps && \
    wget --no-check-certificate https://data.broadinstitute.org/igv/projects/downloads/"${IGV_VER%.*}"/IGV_Linux_"${IGV_VER}".zip && \
    unzip -q IGV_Linux_"${IGV_VER}".zip && rm IGV_Linux_"${IGV_VER}".zip && \
    cd IGV_Linux_"${IGV_VER}" && mv igv.sh igv && mv igv_hidpi.sh igv_hidpi && \
    cd / && chmod go+rwX apps

ENV PATH="/apps/IGV_Linux_${IGV_VER}:$PATH"

VOLUME ["/data"]
WORKDIR /data

CMD ["/bin/bash"]
