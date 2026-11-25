---
title: "Azure Cloud Cert Guide"
date: 2024-08-22
published: true
tags:
- work
categories: blog
toc: true
toc_sticky: true
header:
    teaser: "/../assets/2024-08-22-azure-cloud-practitioner-cert/default-thumbnail.png"
excerpt: "2024-08-22-azure-cloud-practitioner-cert"
---


# Azure Cloud

## OSI Model

![computer network](/../assets/2024-08-22-azure-cloud-practitioner-cert/computer-network.png)


![osi](/../assets/2024-08-22-azure-cloud-practitioner-cert/OSI Model.png)

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

## azure Networking

I've been lucky. While working at [OJCommerce](https://www.ojcommerce.com/), the IT Infrastructure guy made me realize... it's just networking and he teaches basics Networking ![alt text](/../assets/2024-08-22-azure-cloud-practitioner-cert/someelse-cpu.png)


![azure-intro-networking](/../assets/2024-08-22-azure-cloud-practitioner-cert/azure-intro-networking.png)



### Zone & Region

1 Region = Multiple AZ


![zone & region](/../assets/2024-08-22-azure-cloud-practitioner-cert/zoneac.png)

### VPC & Subnet
![alt text](/../assets/2024-08-22-azure-cloud-practitioner-cert/vpc&subnet.png)


### CIDR

[subnet calculator](https://mxtoolbox.com/subnetcalculator.aspx)

$\text{Classless Inter Domain Routing} =  \text{base address} + \text{ prefix}$

| IPv4                                     | IPv6                                     |
| ---------------------------------------- | ---------------------------------------- |
| Identity of the each host in the network | Identity of the each host in the network |
| e.g) 192.168.56.212                      | e.g) 11000000.10101000.0111000.11010100  |


![alt text](/../assets/2024-08-22-azure-cloud-practitioner-cert/cidr.png)

● azure VPC CIDR (IPv4)
    - ○ VPC prefix between /16 (65536 IPs) and /28 (16 IPs)
    - ○ RFC 1918 IP ranges for Private network and corresponding azure recommended ranges
        - ■ 10.0.0.0/8 => 10.0.0.0 – 10.255.255.255
        - ■ 172.16.0.0/12 => 172.16.0.0 - 172.31.255.255
        - ■ 192.168.0.0/16 => 192.168.0.0 - 192.168.255.255
    - ○ Subnet CIDR prefix between /16 to /28 (same as VPC CIDR)
    
● azure VPC CIDR (IPv6)
    - ○ VPC CIDR with prefix /56 (2^72 IPs)
    - ○ IPv6 CIDR is allocated by azure
    - ○ Subnet CIDR prefix /64
    - ○ IPv6 IP addresses are globally unique and publicly routable

### Route Tables
### Internet Gateway
### Security Groups
### Network ACL


![alt text](/../assets/2024-08-22-azure-cloud-practitioner-cert/network.png)


## Azure Cloud Practitioner

One thing we must understand is Shared Responsibility Model,
• Cloud Provider ("Security of the Cloud"): Physical data centers, server hardware, physical networking, virtualization layers, and core service operations.
• Customer ("Security in the Cloud"): Data classification and encryption, user accounts and access permissions (IAM/RBAC), endpoint security, and safe configuration of cloud resources.


### Microsoft Azure organizational hierarchy

#### - Managment Group
Organize multiple subscriptions into a unified hierarchy

#### - Subscriptions 
Act as the primary **billing boundary** and high-level access/scale boundary in Azure.

#### - Resource Groups
Serve as logical containers that hold related resources for an Azure solution.

```
Tenant Root Group (Comcast Global)
│
├── 📁 Management Group: Comcast-US (US Compliance & East/West US Regions)
│   │
│   ├── 🔑 Subscription: US-Production-Sub (US Prod Billing & Access)
│   │   │
│   │   └── 📦 Resource Group: rg-us-billing-app
│   │       ├── ⚙️ Resource: App Service (Web Frontend)
│   │       ├── ⚙️ Resource: SQL Database (Customer Data)
│   │       └── ⚙️ Resource: Key Vault (Secrets & Keys)
│   │
│   └── 🔑 Subscription: US-DevTest-Sub (US Sandbox Billing)
│       │
│       └── 📦 Resource Group: rg-us-billing-dev
│           └── ⚙️ Resource: App Service (Test Environment)
│
└── 📁 Management Group: Comcast-India (India Data Residency & Central/South India Regions)
    │
    ├── 🔑 Subscription: India-Production-Sub (India Prod Billing & Access)
    │   │
    │   └── 📦 Resource Group: rg-india-portal-app
    │       ├── ⚙️ Resource: VM Scale Set (Backend Server)
    │       ├── ⚙️ Resource: Virtual Network (Private Network)
    │       └── ⚙️ Resource: Storage Account (Logs & Files)
    │
    └── 🔑 Subscription: India-DevTest-Sub (India Sandbox Billing)
        │
        └── 📦 Resource Group: rg-india-portal-dev
            └── ⚙️ Resource: VM (Test Server)
```

> Azure Policy can be assigned at any level of the Azure hierarchy

### [Azure Global Backbone](https://datacenters.microsoft.com/globe/explore/)
Determines where your data physically lives

#### - Azure Region
A geographical area on the planet containing at least one, but usually multiple, data centers located close together and connected via a dedicated low-latency network.

Regions that support Availability Zones always have a minimum of **3** AZs

#### - Region Pairs 
Two Azure regions associated by Microsoft — typically within the same geography. Microsoft uses *serialized* platform updates so that only one region in a pair is updated at a time

```
Day 1-2:  [Central India (Pune)]  ──▶ 🔄 Receiving Azure Platform Updates
          [South India (Chennai)] ──▶ ✅ Untouched & Fully Operational (Backup Ready)

Day 3-4:  [Central India (Pune)]  ──▶ ✅ Update Complete & Verified Healthy
          [South India (Chennai)] ──▶ 🔄 Receiving Azure Platform Updates

```

#### - Availability Zone
A physically separate group of datacenters within an Azure region, equipped with independent power, cooling, and networking. Atleast 1 is enough to be called AZ


![Global Backbone](https://kodekloud.com/kk-media/image/upload/v1752868190/notes-assets/images/AZ900-Microsoft-Azure-Fundamentals-Regions-and-Availability-Zones/disaster-recovery-azure-regions-zones.jpg)


### Cloud Computing

#### - Virtual Machines
cloud based simulation which includes GUI+ OS.  It acts like a physical computer with virtualized CPU, memory, storage, and networking, while giving you full control over the operating system and software.


When you deploy a VM, Azure provisions several interconnected components:
• **Compute**: Virtual CPUs (vCPUs) and RAM based on the chosen VM size.
• **Storage (Azure Managed Disks)**: Typically an OS Disk (for the operating system), optional Data Disks (for application data), and a Temporary Disk (on certain sizes for short-term swap/page files).
• **Networking**: A Network Interface Card (NIC) attached to a Virtual Network (VNet) subnet, optionally paired with a Public IP (IPv4 / IPv6 ) and a Network Security Group (NSG) firewall.


##### [Azure VM Size (SKU) Naming Convention](https://learn.microsoft.com/en-us/azure/virtual-machines/vm-naming-conventions#naming-convention-explanation)
> Standard_ + [Family] + [Sub-family]* + [# of vCPUs] + [Additive Features]* + _v[Version]

| Series       | Category                 | Key Characteristics                     |
| :----------- | :----------------------- | :--- ---------------------------------- |
| **B-series** | Burstable                | low baseline usage with periodic spikes |
| **D-series** | General Purpose          | Balanced CPU-to-memory ratio across (web app, general DB)     |
| **E-series** | Memory Optimized         | High memory-to-vCPU ratio (~8 GiB RAM per vCPU), Large relational/NoSQL databases, analytics, in-memory caches |
| **F-series** | Compute Optimized        | High vCPU-to-memory ratio for CPU-heavy tasks | Batch processing, gaming, high-traffic web servers |
| **L-series** | Storage Optimized        | High disk throughput and low latency with local NVMe storage. NoSQL databases, data warehousing, big data |
| **M-series** | Ultra Memory Optimized   | Massive memory footprints (up to terabytes of RAM).  Large in-memory databases (e.g., SAP HANA) |
| **H-series** | High Performance Computing | Built for tightly coupled, compute-intensive HPC workloads. Weather modeling, fluid dynamics, scientific simulations |
| **N-series** | GPU Accelerated          | Equipped with NVIDIA or AMD GPUs.  AI/ML training, inference, graphics rendering |


| Subfamily Letter | Differentiation / Purpose | Applicable Series / Notes |
| :--- | :--- | :--- |
| **B** | Memory bandwidth optimized | General specialized differentiation |
| **C** | Confidential computing | `DC`, `EC`, `NCC` series |
| **C** | Compute intensive | `HC`, `NC`, `NCC` series |
| **D** | AI training and inference optimized | Specialized AI workloads |
| **G** | Cloud gaming and remote desktop optimized | Gaming & VDI workloads |
| **H** | High core density | High-density compute workloads |
| **V** | Visualization and graphics optimized | Graphics & rendering workloads |
| **X** | Extra memory | High-memory configurations |


Old Convention: **Standard_DS2_v2** 
New Convention: **Standard_D2s_v5**

| Part | Value | Meaning |
|:-----|:-----:|:-------:|
| Standard_ |Tier    | Standard pricing/performance tier |
| 2         | vCPUs	 | 2 virtual CPUs.                   |
| s         | Additive Feature   | Premium SSD storage capable       |
| _v2       | Version	| 2nd generation hardware (older Intel Xeon processors). |



When app is running on VM, unplanned updates, disruptions may affect availability. To address use **Avalilability Sets**
- Fault Domains
- Update Domains

![Availability sets](https://kodekloud.com/kk-media/image/upload/v1752868312/notes-assets/images/AZ900-Microsoft-Azure-Fundamentals-Virtual-Machines-and-Virtual-Machine-Scale-Sets/availability-sets-fault-domains-diagram-2.jpg)


Connectivity Options:
- public endpoints
- private endpoints
- virtual network peering


**[AZ VM CMDs](https://learn.microsoft.com/en-us/cli/azure/vm?view=azure-cli-latest)**


1. VM Creation & Configuration

```sh
az login
az account list --output table
az account set --subscription "<SUBSCRIPTION_ID_OR_NAME>"

# List available locations (e.g., centralindia, southindia)
az account list-locations --output table

# Create Resource Group
az group create --name rg-vm-demo --location centralindia

# List VMs in the centralindia
az vm list-sizes --location centralindia --output table

# Find Ubuntu images
az vm image list --location centralindia --publisher Canonical --offer ubuntu-24_04-lts --all --output table
# REDHAT:::    --publisher RedHat --offer RHEL 
# MICROSOFT::: --publisher MicrosoftWindowsServer --offer WindowsServer

az vm create -g rg-vm-demo --name vm-linux-01 --location centralindia --zone 1 --size Standard_B2s --image Canonical:ubuntu-24_04-lts:server:latest --admin-username azureuser --authentication-type ssh --generate-ssh-keys --public-ip-sku Standard   --boot-diagnostics-storage ""
# ADMIN:::: --admin-username azureadmin  --admin-password "<StrongPassword123!>"    
# BOOT DIAGNOSTICS:::::  --boot-diagnostics-storage "" enables Azure-managed boot diagnostics , --boot-diagnostics-storage <STORAGE_ACCOUNT_NAME_OR_ID>
# Enable it after creation via az vm boot-diagnostics enable


# Details of the VM in the resource group
az vm show -g rg-vm-demo --name vm-linux-01 --show-details --query publicIps   --output tsv

# Open Port
az vm open-port --resource-group rg-vm-demo --name vm-win-01 --port 3389

# View boot log / serial output
az vm boot-diagnostics enable --resource-group rg-vm-demo --name vm-linux-01    
az vm boot-diagnostics disable --resource-group rg-vm-demo --name vm-linux-01    
az vm boot-diagnostics get-boot-log --resource-group rg-vm-demo --name vm-linux-01
```
2. VM Mangement Activities
```bash
az vm start --resource-group rg-vm-demo --name vm-linux-01   # START the VM
az vm restart  -g rg-vm-demo --name vm-linux-01              # RESTART the VM
az vm stop --resource-group rg-vm-demo --name vm-linux-01    # STOP  the VM
az vm deallocate --resource-group rg-vm-demo --name vm-linux-01 # STOP the VM and Release the Hardware ( stop the Billing )     
az vm delete -g rg-vm-demo --name vm-linux-01  --yes         # Delete only the VM (leaves disks, NIC, and public IP intact):
# Order must be followed, bcz Azure enforce strict parent-child resource locks.  DELETE::::  VM -> NIC -> OS Disk and Data Disks -> Public IP -> NSG


## Capture 
NIC_IDS=$(az vm show -g $RG -n $VM --query "networkProfile.networkInterfaces[].id" -o tsv)
OS_DISK=$(az vm show -g $RG -n $VM --query "storageProfile.osDisk.managedDisk.id" -o tsv)
DATA_DISKS=$(az vm show -g $RG -n $VM --query "storageProfile.dataDisks[].managedDisk.id" -o tsv)
PIP_IDS=$(az network nic show --ids $NIC_IDS --query "ipConfigurations[].publicIPAddress.id" -o tsv 2>/dev/null)
NSG_IDS=$(az network nic show --ids $NIC_IDS --query "networkSecurityGroup.id" -o tsv 2>/dev/null)
# 2. Delete the VM first
az vm delete -g $RG --name $VM --yes
# 3. Delete NIC (must happen before Public IP and NSG)
[ -n "$NIC_IDS" ] && az network nic delete --ids $NIC_IDS
# 4. Delete OS Disk, Data Disks, Public IP, and NSG
[ -n "$OS_DISK" ] && az disk delete --ids $OS_DISK --yes
[ -n "$DATA_DISKS" ] && az disk delete --ids $DATA_DISKS --yes
# Delete Public IP and Network Security Rules
[ -n "$PIP_IDS" ] && az network public-ip delete --ids $PIP_IDS
[ -n "$NSG_IDS" ] && az network nsg delete --ids $NSG_IDS



# az group delete --name $RG --yes --no-wait                 


# Resize
az vm list-vm-resize-options --resource-group $RG --name $VM_NAME --output table 
az vm resize --resource-group $RG --name $VM_NAME   --size Standard_B4ms   # Deallocate First ( notice uptime changes )

# Tags
az vm update --resource-group $RG --name $VM_NAME   --set tags.Environment=Dev tags.Owner=Admin

```
3. Disk MAanagemnt 
4. Network configuration
5. Security Management
6. Backup & Disaster Recovery
7. Monitoring & Troubleshoot
8. OS Administraiton
9. Cost Managment 



#### - Virtual Machine Scale sets
- Automatic Scaling
- Load balancing
- High Availability

![VMSS](https://kodekloud.com/kk-media/image/upload/v1752868315/notes-assets/images/AZ900-Microsoft-Azure-Fundamentals-Virtual-Machines-and-Virtual-Machine-Scale-Sets/azure-vm-scale-set-high-availability.jpg)

#### - Azure Virtual Desktop 
#### - Azure App Services
#### - Azure Container Services
#### - Azure Functions
#### - Azure Virtual Desktop
#### - Azure Kubernets Service


### Networking Service
#### - Virtual Networking
#### - VPN Gateway
#### - Express Route
#### - Azure DNS


### Storage
#### - Blob
#### - File
#### - Queue
#### - Table
#### - Azure Disk 
#### - Azure Data Lake Storage
#### - Azure File Sync
#### - Azure Data Box


### Databases
#### - Azure SQL Database
#### - Azure SQL Managed Instance
#### - Azure Database for PostgreSQL / MySQL
#### - Azure Cosmos DB
#### - Azure Managed Redis



### Redundancy Options
#### - Locally RS
#### - Zone 
#### - Geo 
#### - Geo-Zone


### Identity, Access and Security
#### - Microsoft Entra ID
#### - Role-Based Access Control (RBAC)
#### - Azure Key Vault
#### - Microsoft Defender for Cloud
#### - Network Security Groups 
#### - Azure Firewall


### Integration
#### - APIM
#### - Azure Service Bus
#### - Azure Event Grid
#### - Azure Logic Apps



### Cost 
#### - 
#### - 
#### - 
#### - 


### Goverannce
#### - Azure Policy
#### - 
#### - 
#### - 
#### - 

### Monitoring
#### - 
#### - 
#### - 
#### - 
#### - 


### AI & Machine Learning
#### - Azure Machine Learning Studio



### DevOps & Infrastructure as Code (IaC)
#### - Azure DevOps
#### - GitHub Actions for Azure
#### - Azure Resource Manager (ARM) Templates
#### - Bicep
#### - Terraform on Azure
