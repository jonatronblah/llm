# LLM/RAG Template for Python

## Introduction
This is an example project for running basic RAG applications in Python using the following software/libraries:
- llamma-cpp-python
- llamaindex
- pgvector

## Requirements
- Docker + NVIDIA Container Toolkit
- WSL(2) or Linux
- (Recommended) A CUDA 12.4+ compatible GPU with at least 16 gb of memory

## Contents

Two jupyter notebooks are provided to demo retrieval using the Qwen2.5 family of models, llamacpp, llamaindex, and pgvector:
- The first uses data scraped from the TTLG forums (ttlg.com/forums), parses the raw HTML and desired tags using beautifulsoup4 and parses document nodes into a single vector index. This example uses bartowski's Qwen-2.5-14B-Instruct 6_K gguf quantization.

- The second parses the source code of the monome crow software library (https://github.com/monome/crow/). Separate indexes and codesplitting processes are executed for 3 languages and file types: python, lua and C. All three indexes are exposed to the query engine with a llamaindex QueryFusionRetriever. This example uses bartowski's Qwen-2.5-Coder-14B-Instruct 6_K gguf quantization.

Each notebook provides an appropriate system prompt for the model.

Tokenization is accomplished using the original Qwen2.5-(Coder-)14B-Instruct tokenizer. The embedding model used is BAAI's 
bge-base-en-v1.5 FlagEmbedding. 

## Get Started
- create a .env in project root with the following environment variables:
    - POSTGRES_USER
    - POSTGRES_PASSWORD
    - POSTGRES_DB
    - HF_TOKEN

## Tips
- If using large models on wsl2, you'll probably want to change your wsl configuration to something like the following:
`[wsl2]
memory=32GB`
- This template is built around cpu/cuda. You'll need a gpu that supports CUDA 12.6 and has 16 gb of memory to run at decent speed without making any changes. 
- This project uses `nvidia/cuda:12.6.2-cudnn-runtime-ubuntu22.04` as a base image. Other CUDA versions, configurations and operating systems can be found on nvidia's CUDA docker repository: https://hub.docker.com/r/nvidia/cuda


