# Base image
FROM python:3.10.17-slim-bookworm
## Update Linux packages and install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential gcc git libbz2-dev liblzma-dev libz-dev nano wget && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
## Install Borzoi dependencies
RUN git clone https://github.com/calico/baskerville.git /app/baskerville && \
    pip install /app/baskerville && \
    rm -rf /app/baskerville
## Install Borzoi
RUN git clone https://github.com/calico/borzoi.git /borzoi && \
    pip install /borzoi
## Install Bedtools
RUN cd /tmp && \
    wget https://github.com/arq5x/bedtools2/releases/download/v2.29.1/bedtools-2.29.1.tar.gz && \
    tar -zxvf bedtools-2.29.1.tar.gz && \
    cd bedtools2 && \
    make && \
    make install && \
    cd .. && \
    rm -rf bedtools-2.29.1.tar.gz bedtools2
## Define environment variables
ENV BORZOI_DIR=/borzoi
ENV PATH=/borzoi/src/scripts:$PATH
ENV PYTHONPATH=/borzoi/src/scripts
WORKDIR /home
