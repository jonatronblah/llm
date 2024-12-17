FROM nvidia/cuda:12.6.2-cudnn-runtime-ubuntu22.04 AS base

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y git build-essential \
    gcc wget \
    ocl-icd-opencl-dev opencl-headers clinfo \
    libclblast-dev libopenblas-dev \
    && mkdir -p /etc/OpenCL/vendors && echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd

FROM base AS req

COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

RUN uv python install 3.12.7

WORKDIR /setup
RUN uv venv

RUN uv pip install torch torchvision torchaudio

ENV CUDA_DOCKER_ARCH=all
ENV GGML_CUDA=1
RUN CMAKE_ARGS="-DGGML_CUDA=on" \
uv pip install llama-cpp-python==0.2.90 \
  --extra-index-url https://abetlen.github.io/llama-cpp-python/whl/cu124

RUN uv pip install llama-index llama-index-llms-huggingface llama-index-llms-huggingface-api llama-index-vector-stores-postgres llama-index-embeddings-huggingface llama-index-llms-llama-cpp

RUN uv pip install huggingface-hub[cli] jupyter psycopg[binary] beautifulsoup4 python-dotenv

COPY .env .

RUN uv pip install llama-cpp-python==0.3.4 \
  --extra-index-url https://abetlen.github.io/llama-cpp-python/whl/cu124













## lgm

# WORKDIR /lgm

# xformers is required! please refer to https://github.com/facebookresearch/xformers for details.
# for example, we use torch 2.1.0 + cuda 11.8
# RUN uv pip install -U xformers 

# # a modified gaussian splatting (+ depth, alpha rendering)
# # RUN git clone --recursive https://github.com/ashawkey/diff-gaussian-rasterization
# # RUN uv pip install ./diff-gaussian-rasterization 

# # # for mesh extraction
# # RUN uv pip install git+https://github.com/NVlabs/nvdiffrast

# RUN git clone https://github.com/3DTopia/LGM.git
# # other dependencies
# RUN uv pip install -r LGM/requirements.txt

# RUN huggingface-cli download ashawkey/LGM model_fp16_fixrot.safetensors








