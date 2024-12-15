# LLM/RAG Template for Python

## Using
- Huggingface Transformers
- llamma-cpp-python
- llamaindex
- pgvector

## Requirements
- Docker + NVIDIA Container Toolkit
- WSL(2) or Linux

## Get Started
- create a .env in project root with the following environment variables:
    - POSTGRES_USER
    - POSTGRES_PASSWORD
    - POSTGRES_DB
    - HF_TOKEN

## Tips
- If using large models on wsl2, you'll probably want to change your wsl configuration:
`[wsl2]
memory=32GB`
- This template is built around cpu/cuda. You'll need a gpu that supports CUDA 12.6 and has 16 gb of memory to run at decent speed without making any changes.

## Contents

A jupyter notebook is provided for ingestion of html data (scraped from ttlg.com/forums) and a basic RAG setup using llamaindex and pgvector as index storage.

By default, this template utilizes bartoski's GGUF quantization of qwen2.5 uncensored 14B instruct model. Tokenization is accomplished using the original quen2.5 14B instruct tokenizer. The embedding model is BAAI's 
bge-base-en-v1.5 FlagEmbedding. 