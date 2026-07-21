+++
date = "2026-07-21 1:01:35"
title = "LLM Inference"
description = "Let's Serve better with KServe"

[taxonomies]
tags = ["AI/ML","Vllm"]

[extra]
local_image = 'images/thumbnails/blog/kserve.png'
quick_navigation_buttons = true
toc= false
+++



<details>
    <summary>Table Of Content</summary>
    <!-- toc -->
</details>

# 1. Overview
Large LLMs like Llama-3-70b or Falcon 180B may not fit in a single GPU.

If training/serving a model on a single GPU is too slow or if the model’s weights do not fit in a single GPU’s memory, transitioning to a multi-GPU setup may be a viable option.

But serving large language models (LLMs) with multiple GPUs in a distributed environment might be a challenging task.


# 2. Checking the Model Footprint of the Model
Before deploying a model in a distributed environment, it is important to check the memory footprint of the model.

To begin estimating how much vRAM is required to serve your LLM, we can use these tools:

- [HF Model Memory Usage](https://huggingface.co/spaces/hf-accelerate/model-memory-usage)
- [GPU Poor vRAM Calculator](https://rahulschand.github.io/gpu_poor/)
- [LLM Model VRAM Calculator](https://huggingface.co/spaces/NyxKrage/LLM-Model-VRAM-Calculator) only for quantization models 
- [LLM Explorer](https://llm.extractum.io/) to check raw model vRAM size consumption

<!-- https://github.com/rh-aiservices-bu/gpu-partitioning-guide#14-pros-and-cons-of-gpu-partitioning-methods -->
<!-- https://github.com/rh-aiservices-bu/multi-gpu-llms#1-overview -->
# 3. GPU Partitioning Overview
![Overview](https://github.com/rh-aiservices-bu/gpu-partitioning-guide/raw/main/assets/gpu-sharing-overview.png)
## Time-slicing
## MIG
## MPS

# Pros and Cons of GPU Partitioning Methods
# Requirements: GPU Nodes with GPUs
# Validate and GPU Partioning
# Testing with LLMs
# Nvidia GPU Operator

# Links of Interest
- [VRAM Calculator](https://rahulschand.github.io/gpu_poor/)
- [](https://blog.vllm.ai/2023/06/20/vllm.html)
- [](https://towardsdatascience.com/choosing-the-right-gpu-for-deep-learning-on-aws-d69c157d8c86)