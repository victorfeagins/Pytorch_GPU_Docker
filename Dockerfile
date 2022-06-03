FROM nvidia/cuda:11.0.3-base-ubuntu20.04
RUN apt-get update

ENV CUDA_VERSION=cu113
ENV TORCH_VERSION=1.10.0

RUN apt-get -y install python3
RUN apt-get -y install python3-pip

RUN pip install torch==$TORCH_VERSION+$CUDA_VERSION torchvision==0.11.0+$CUDA_VERSION torchaudio==0.10.0 -f https://download.pytorch.org/whl/torch_stable.html



RUN mkdir /app
WORKDIR /app

# All users can use /home/user as their home directory.
RUN mkdir /home/user
ENV HOME=/home/user
RUN chmod 777 /home/user


CMD ["python3"]