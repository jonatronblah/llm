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