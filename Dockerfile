FROM nvidia/cuda:12.6.2-cudnn-runtime-ubuntu22.04 AS base

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y git build-essential \
    gcc wget \
    ocl-icd-opencl-dev opencl-headers clinfo \
    libclblast-dev libopenblas-dev \
    && mkdir -p /etc/OpenCL/vendors && echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd

FROM base AS req

# install python with uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv
RUN uv python install 3.12.7

WORKDIR /setup
RUN uv venv

# install llama-cpp-python 0.2.90
# requires env variables for CUDA installation
# llamaindex dependency on version
ENV CUDA_DOCKER_ARCH=all
ENV GGML_CUDA=1
RUN CMAKE_ARGS="-DGGML_CUDA=on" \
uv pip install llama-cpp-python==0.2.90 \
  --extra-index-url https://abetlen.github.io/llama-cpp-python/whl/cu124

# install other requirements
COPY requirements.txt .
RUN uv pip install -r requirements.txt

# get the latest version of llama-cpp-python after llamaindex is installed
RUN CMAKE_ARGS="-DGGML_CUDA=on" \
uv pip install llama-cpp-python==0.3.4 \
  --extra-index-url https://abetlen.github.io/llama-cpp-python/whl/cu124

# copy .env file for usage with jupyter notebooks via python-dotenv
COPY .env .




