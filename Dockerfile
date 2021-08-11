# FROM ubuntu:18.04
FROM nvidia/cuda:10.2-cudnn7-runtime-ubuntu18.04

# Add the environment to the path (for the containers)
ENV PATH="/root/miniconda3/bin:${PATH}"

# Add the arg to the path (for the image)
ARG PATH="/root/miniconda3/bin:${PATH}"

# Update the ubuntu, and install htop python3-dev and wget (we will need them for conda)
RUN apt update \
    && apt install -y htop python3-dev wget

# Download conda and install it than delete it.
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir root/.conda \
    && sh Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh

# Run conda and create a new environment called "ml" with python
RUN conda create -y -n ml python=3.7

# Add the environment to the path
COPY . src/

# Activate the env and Install the dependencies
RUN /bin/bash -c "cd src \
    && source activate ml \
    && pip install -r requirements.txt"
