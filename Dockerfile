# Use an official NVIDIA CUDA base image with CUDA 11.8 and cuDNN 8.9
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04

# Set a label or maintainer for the Docker image
LABEL maintainer="you@example.com"

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Update and install software-properties-common for adding repositories
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update

# Install Python 3.10
RUN apt-get install -y python3.10 python3.10-distutils python3.10-dev

# # Create a symbolic link for python3
# RUN ln -s /usr/bin/python3.10 /usr/bin/python3 && ln -s /usr/bin/python3.10 /usr/bin/python

# Install pip for Python 3.10
RUN apt-get install -y wget && \
    wget https://bootstrap.pypa.io/get-pip.py && \
    python3.10 get-pip.py && \
    rm get-pip.py

# Upgrade pip
RUN pip install --upgrade pip

# Install TensorFlow and PyTorch with GPU support
RUN pip install tensorflow[and-cuda] && pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

# Revert to a non-interactive frontend
ENV DEBIAN_FRONTEND=dialog

# Set the working directory
WORKDIR /app

# Optional: Copy your application code with dependencies
COPY . /app

# Command to run on container start
CMD ["python", "your_script.py"]
