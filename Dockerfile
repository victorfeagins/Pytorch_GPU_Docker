FROM nvidia/cuda:11.0.3-base-ubuntu20.04
RUN apt-get update

ENV CUDA_VERSION=cu113
ENV TORCH_VERSION=1.10.0

RUN apt-get -y install python3
RUN apt-get -y install python3-pip

RUN pip install torch==$TORCH_VERSION+$CUDA_VERSION torchvision==0.11.0+$CUDA_VERSION torchaudio==0.10.0 -f https://download.pytorch.org/whl/torch_stable.html

RUN apt-get install -y \
    wget\
    curl \
    ca-certificates \
    vim \
    sudo \
    git \
    bzip2 \
    libx11-6 \
 && rm -rf /var/lib/apt/lists/*



RUN mkdir /app
WORKDIR /app

# All users can use /home/user as their home directory.
RUN mkdir /home/user
ENV HOME=/home/user
RUN chmod 777 /home/user



# Install TorchNet, a high-level framework for PyTorch.
RUN pip install --no-cache-dir torchnet==0.0.4

# Install Requests, a Python library for making HTTP requests.
RUN pip install --no-cache-dir requests==2.19.1

# Install Graphviz.
RUN pip install --no-cache-dir graphviz==0.20

RUN pip install --no-index torch-spline-conv -f https://data.pyg.org/whl/torch-$TORCH_VERSION+$CUDA_VERSION.html \
 && pip install torch-geometric \
 && pip install --no-cache-dir pytorch-lightning==1.4.1  transformers==4.19.2\
 && pip install --no-cache-dir --no-deps sentence-transformers==2.2.0 sentencepiece==0.1.96 \
 && pip install --no-cache-dir nltk==3.7 ipykernel==6.13.0 \
 && pip install --no-cache-dir dgl==0.6.1

#RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends \
#    libgtk2.0-0 \
#    libcanberra-gtk-module \
# && sudo rm -rf /var/lib/apt/lists/*

# Install HDF5 Python bindings.
RUN pip install h5py
RUN pip install h5py-cache


CMD ["python3"]