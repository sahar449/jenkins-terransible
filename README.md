# Infrastructure as Code with Terraform, Ansible, and Jenkins

![image](https://github.com/sahar449/jenkins-terransible/assets/71507445/0ef6d6f2-8e75-4bed-966d-a6f2cd69d876)


## Overview

This repository contains the code and configuration for building, configuring, and orchestrating infrastructure using Terraform for provisioning, Ansible for configuration management, and Jenkins for automation. The pipelines run automatically, and monitoring infrastructure using Prometheus and Grafana is included.

## Terraform Infrastructure

Terraform,build the ec2 and security groups in aws, in region us-east-1, with specific ami(to the region), insert your puclic ip in teh sg groups located in tf_module/main.tf lines (38, 59).

## Ansible Configuration

Ansible install automatically Promethus and Grafana in debian distro (Ubuntu and Debian), in the playbooks located in playbooks folder.
## Jenkins Orchestration

Jenkinsfile run the pipeline, please add to your jenkins server access and secret of aws.

## Monitoring Infrastructure

In the end of the pipeline, you will get Monitoring Infrastructure.

## Technologies Used

- [Terraform](https://www.terraform.io/): Infrastructure provisioning tool
- [Ansible](https://www.ansible.com/): Configuration management tool
- [Jenkins](https://www.jenkins.io/): Automation and orchestration tool
- [Prometheus](https://prometheus.io/): Monitoring and alerting toolkit
- [Grafana](https://grafana.com/): Observability platform

## Folder Structure

- `/tf_module`: Terraform configuration files for infrastructure provisioning.
- `/playbooks`: Ansible playbooks and roles for configuring the infrastructure.
- `Jenkinsfile`: Jenkins pipeline scripts for orchestration.

## Getting Started

1. **Clone the Repository:**

    ```bash
    git clone https://github.com/sahar449/jenkins-terransible.git
    cd your-repository
    ```

2. **Orchestrate with Jenkins:**

    Only run the pipeline and choose apply or destroy (terraform)

3. **Monitoring Infrastructure:**

    - The monitoring infrastructure is automatically included during the provisioning process.
    - Access Prometheus dashboard: [Use the output grafana in tf_module/prometheus]
    - Access Grafana dashboard: [Use the output grafana in tf_module/grafana]



