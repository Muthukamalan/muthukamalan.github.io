---
title: "GPU LLM Inference"
date: 2026-07-27
tags:
- gpu
categories: blog
toc: true
toc_sticky: true
header:
    teaser: "/../assets/2026-07-27-gpu-llm-inference/default-thumbnail.png"
excerpt: 
---

WIP

# prerequisites

> [!INFO] Basics
> 4 bits = 0.5 byte
> 8 bits = 1 byte
> 16 bits = 2 byte
> 32 bits = 4 byte
> 8000 bits = 1000 byte ( $10^{3}$ ) = 1 KB  = $\times{10^{-3}}$ MB   = $\times{10^{-6}}$ GB 
   

$$27.3= 273\times{10^{-1}}$$
$273-> \text{mantissa}$
$10^{-1} -> exponent$


![alt text](/../assets/2026-07-27-gpu-llm-inference/int-image.png)
![alt text](/../assets/2026-07-27-gpu-llm-inference/float-image.png)
![alt text](/../assets/2026-07-27-gpu-llm-inference/other-image.png)


[Binary Representation](https://stackoverflow.com/questions/16444726/binary-representation-of-float-in-python-bits-not-hex)

|                         | RANGE                                             | BITS | Sign | Exponent | Mantissa |
| ----------------------- | ------------------------------------------------- | ---- | ---- | -------- | -------- |
| Double precision (FP64) | $\pm1.79e^{\pm308}$                               | 64   | 1    | 11       | 52       |
| Single precision (FP32) | $\pm3.4e^{\pm 38}$                                | 32   | 1    | 8        | 23       |
| TF32                    | $\pm3.4e^{+38}$                                   | 19   | 1    | 8        | 10       |
| bfloat16                | $\pm3.3e^{+38}$                                   | 16   | 1    | 8        | 7        |
| Half precision (FP16)   | $\pm 3.4e^{+38}$                                  | 16   | 1    | 5        | 10       |
| FP8                     | $\pm65504$                                        | 8    | 1    | 5        | 2        |
| INT8                    | -128 -> 127                                       | 8    | 1    | 7        |          |
| FP4                     | $\pm{\{0.0, 0.5, 1.0, 1.5, 2.0, 3.0, 4.0, 6.0}\}$ | 4    | 1    | 2        | 1        |
| INT4                    | -8 -> -7                                          | 4    | 1    | 3        |          |


Once you understand these formats, you can make sense of hardware performance metrics, FLOPS, TFLOPS

**FLOPs**:  a measure of how many additions or multiplications involving floating point numbers a processor can complete in one second. 

- Addition: `2.5 + 3.1` → 1 FLOP
- Subtraction: `7.2 - 1.4` → 1 FLOP
- Multiplication: `2.5 × 3.1` → 1 FLOP

![alt text](/../assets/2026-07-27-gpu-llm-inference/matrix-multiply-image.png)

> $2^{3}$ is Not Fit for Rectangular Matrix

On the **HARDWARE** Side,

[GPU Specifications](https://www.techpowerup.com/gpu-specs/)

| Introduced       | Example GPUs   | Primary focus                     |                                            |
| ---------------- | -------------- | --------------------------------- | ------------------------------------------ |
| **Ampere**       | 2020           | A100, RTX 30 series               | AI training, HPC and graphics              |
| **Hopper**       | March 2022     | H100, H200                        | Data-centre AI, LLM training and inference |
| **Ada Lovelace** | September 2022 | L4, L40S, RTX 4050, RTX 40 series | Graphics and energy-efficient inference    |
| **Blackwell**    | March 2024     | B200, GB200, RTX 5050–5090        |                                            |




| Feature          | Description                                                             | Ampere: A100 SXM       | Hopper: H100 SXM             | Ada: L4                   | Blackwell: RTX 5090     |
| ---------------- | ----------------------------------------------------------------------- | ---------------------- | ---------------------------- | ------------------------- | ----------------------- |
| Primary purpose  |                                                                         | Training and inference | Large training and inference | Efficient inference/video | Consumer/workstation AI |
| Timeline         |                                                                         | 2020                   | 2022                         | 2023                      | 2024                    |
| CUDA cores       | designed to run in lock-step to process data in bulk                    | 6,912                  | 16,896                       | 7,424                     | 21,760                  |
| VRAM             | memory on a graphics card                                               | 40/80 GB HBM2e         | 80 GB HBM3                   | 24 GB GDDR6               | 32 GB GDDR7             |
| Memory bandwidth |                                                                         | Up to 2.039 TB/s       | About 3.35 TB/s              | 300 GB/s                  | 1.792 TB/s              |
| NVLink           | allows for faster communication btw GPUs, exceeding speed of PCIe slots | Yes, up to 600 GB/s    | Yes, up to 900 GB/s          | No                        | No                      |
| MIG              |                                                                         | Yes, up to 7 instances | Yes, up to 7 instances       | No                        | No                      |
| FP8 Tensor Core  |                                                                         | No native FP8          | Yes                          | Yes                       | Yes                     |
| FP4 support      |                                                                         | No                     | No native FP4                | No                        | Yes                     |
| Typical power    |                                                                         | 400 W                  | Up to 700 W                  | 72 W                      | 575 W                   |
| Drivers          | Vulkan, OpenGL translate software commands -> compute task              |                        |                              |                           |                         |

*SXM means instead of PCIe Slot mount on Specialized server baseboard ( Higher Powerlimit  )


![alt text](/../assets/2026-07-27-gpu-llm-inference/pipeline-problem.png)
Traditional Metrics, like *Latency*, *Response Time*, *Throughput*
On top of it, 
- Time to First Token (TTFT)
- Inter Token Latency ( ITL )
- Total Time of Generation
- Tokens per Seconds
- Total Cost of Ownership ( TCO ) ( $/token ) = compute + Electricity + Storage + Networking + Monitoring + Engineering Support
- Carbon Foot Print: tonnes CO₂e  (1 tonne CO₂e = 1,000 kg CO₂e)

Roofline Model


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