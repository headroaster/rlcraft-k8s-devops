# RLCraft Server - Kubernetes & Jenkins DevOps Demo

This project contains a containerized RLCraft Minecraft server with Kubernetes deployment and Jenkins automation for CI/CD and backups.

---

## Features

- RLCraft Minecraft server running in a Docker container
- Deployment managed with Kubernetes (Minikube)
- Automated build, deploy, and backup pipelines using Jenkins
- Daily backups of Minecraft world data to local or S3-compatible storage
- Automated server restarts for high availability

---

## Prerequisites

- Ubuntu Linux (tested on 24.04 LTS)
- Docker & Docker CLI installed
- Minikube installed and running
- Kubernetes CLI (`kubectl`) configured
- Jenkins server set up with pipeline access to this repo
- (Optional) S3-compatible storage or local backup storage

---

## Getting Started

### Clone the repository

```bash
git clone https://github.com/headroaster/rlcraft-k8s-devops.git
cd rlcraft-k8s-devops
