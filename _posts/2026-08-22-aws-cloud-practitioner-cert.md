---
title: "AWS Cloud Cert Guide"
date: 2024-08-22
published: true
tags:
- work
categories: blog
toc: true
toc_sticky: true
header:
    teaser: "/../assets/2024-08-22-aws-cloud-practitioner-cert/default-thumbnail.png"
excerpt: "2024-08-22-aws-cloud-practitioner-cert"
---


# AWS Cloud

## OSI Model

![computer network](/../assets/2024-08-22-aws-cloud-practitioner-cert/computer-network.png)


![osi](/../assets/2024-08-22-aws-cloud-practitioner-cert/OSI Model.png)

### Layers Overview

| Layer | Name         | Function                | Example Protocols     |
| ----- | ------------ | ----------------------- | --------------------- |
| 7     | Application  | User interaction        | HTTP, FTP, SMTP       |
| 6     | Presentation | Encryption & formatting | SSL/TLS, JPEG         |
| 5     | Session      | Connection management   | NetBIOS, RPC          |
| 4     | Transport    | Reliable delivery       | TCP, UDP              |
| 3     | Network      | Routing & IP addressing | IP, ICMP              |
| 2     | Data Link    | MAC addressing          | Ethernet, PPP         |
| 1     | Physical     | Data transmission       | Fiber, Ethernet cable |

## AWS Networking

I've been lucky. While working at [OJCommerce](https://www.ojcommerce.com/), the IT Infrastructure guy made me realize... it's just networking and he teaches basics Networking ![alt text](/../assets/2024-08-22-aws-cloud-practitioner-cert/someelse-cpu.png)


![aws-intro-networking](/../assets/2024-08-22-aws-cloud-practitioner-cert/aws-intro-networking.png)



### Zone & Region

1 Region = Multiple AZ


![zone & region](/../assets/2024-08-22-aws-cloud-practitioner-cert/zoneac.png)

### VPC & Subnet
![alt text](/../assets/2024-08-22-aws-cloud-practitioner-cert/vpc&subnet.png)


### CIDR

[subnet calculator](https://mxtoolbox.com/subnetcalculator.aspx)

$\text{Classless Inter Domain Routing} =  \text{base address} + \text{ prefix}$

| IPv4                                     | IPv6                                     |
| ---------------------------------------- | ---------------------------------------- |
| Identity of the each host in the network | Identity of the each host in the network |
| e.g) 192.168.56.212                      | e.g) 11000000.10101000.0111000.11010100  |


![alt text](/../assets/2024-08-22-aws-cloud-practitioner-cert/cidr.png)

● AWS VPC CIDR (IPv4)
    - ○ VPC prefix between /16 (65536 IPs) and /28 (16 IPs)
    - ○ RFC 1918 IP ranges for Private network and corresponding AWS recommended ranges
        - ■ 10.0.0.0/8 => 10.0.0.0 – 10.255.255.255
        - ■ 172.16.0.0/12 => 172.16.0.0 - 172.31.255.255
        - ■ 192.168.0.0/16 => 192.168.0.0 - 192.168.255.255
    - ○ Subnet CIDR prefix between /16 to /28 (same as VPC CIDR)
    
● AWS VPC CIDR (IPv6)
    - ○ VPC CIDR with prefix /56 (2^72 IPs)
    - ○ IPv6 CIDR is allocated by AWS
    - ○ Subnet CIDR prefix /64
    - ○ IPv6 IP addresses are globally unique and publicly routable




### Route Tables
### Internet Gateway
### Security Groups
### Network ACL


![alt text](/../assets/2024-08-22-aws-cloud-practitioner-cert/network.png)


## AWS Cloud Practitioner

### Cloud Computing
### IAM
### EC2
### ELB & AutoScaling
### S3
### DB
### Other compute Services
### Deployment 
### Cloud integration
### Cloud Monitoring
### ML
### Management & Billing
### AWS Architecting & Eco System