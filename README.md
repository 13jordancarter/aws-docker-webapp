# aws-docker-webapp

## Project Overview

This project demonstrates how to build, containerize, and deploy a Python web application to AWS using Docker, Terraform, and an EC2 instance.

The application was developed locally, packaged into a Docker image, and deployed to an AWS EC2 instance. Terraform was used to provision the required AWS infrastructure, while EC2 user data automated the installation and startup of Docker.

The project brought together several cloud engineering concepts, including Infrastructure as Code (IaC), containerization, Linux administration, AWS networking, and application deployment.

## Architecture

**Application deployment flow:**

Local Ubuntu Machine → SCP File Transfer → AWS EC2 → Docker Container → Python Flask Application → Web Browser

Terraform was used to provision the AWS environment before deploying the application.

## Technologies Used

- **AWS EC2:** Hosted the Docker container and web application.
- **AWS VPC:** Provided the isolated network environment.
- **AWS Security Groups:** Controlled inbound and outbound network traffic.
- **Terraform:** Provisioned and managed AWS infrastructure.
- **Docker:** Built and ran the containerized application.
- **Python / Flask:** Created the web application.
- **Linux (Ubuntu / Amazon Linux 2023):** Used for local development and EC2 administration.
- **Git / GitHub:** Managed and documented project files.

## Project Implementation

### 1. Develop the Python Application

Created a simple Python Flask application that displays a welcome message in a web browser.

Configured the application to listen on port 5000 and accept connections from outside the container using 0.0.0.0.

### 2. Containerize the Application

Created a Dockerfile to define how the application would be packaged and executed.

The Dockerfile:
- Used a Python 3.12 slim base image.
- Created an application working directory.
- Installed Flask from requirements.txt.
- Copied the application files into the image.
- Exposed port 5000.
- Defined the command to launch the application.

Built and tested the Docker image locally on Ubuntu before deploying it to AWS.

### 3. Provision AWS Infrastructure with Terraform

Used Terraform to create the AWS environment required to host the application.

Resources provisioned included:

- VPC
- Public subnet
- Internet Gateway
- Route table and route table association
- Security group
- EC2 instance

Configured the EC2 instance to use an existing AWS key pair for SSH access.

### 4. Configure EC2 with User Data

Used Terraform's EC2 user data feature to automate the initial instance setup.

The startup script:
- Updated the Amazon Linux system.
- Installed Docker.
- Enabled the Docker service.
- Started Docker automatically.
- Added the ec2-user account to the Docker group.

This reduced the amount of manual configuration required after launching the instance.

### 5. Deploy the Application to EC2

Connected to the EC2 instance from the local Ubuntu machine using SSH.

Used SCP to transfer the application directory and Dockerfile to the EC2 instance.

Built the Docker image directly on EC2 and launched the application inside a Docker container.

Verified the container was running and confirmed the application was responding from within the EC2 instance.

### 6. Configure and Test Network Access

Configured the EC2 security group with the following inbound rules:

| Type | Port | Source |
| SSH | 22 | My public IP |
| Custom TCP | 5000 | 0.0.0.0/0 |

Tested the application using the EC2 public IPv4 address and port 5000 from a local web browser.

Successfully accessed the deployed Flask application over the internet.

### 7. Manage the Docker Container

Practiced basic container management on the EC2 instance.

Commands used included:

sudo docker ps
sudo docker ps -a
sudo docker logs aws-webapp
sudo docker stop aws-webapp

Verified that the container could be stopped while preserving the container and its underlying Docker image.


### 8. Destroy AWS Infrastructure

After completing deployment and testing, used Terraform to review and destroy the provisioned AWS resources.

terraform plan -destroy
terraform destroy

This removed the infrastructure created for the project and helped prevent unnecessary ongoing AWS costs.


## Key Skills Demonstrated

- Building and testing a Python web application.
- Creating Dockerfiles and building Docker images.
- Deploying and managing Docker containers on Linux.
- Provisioning AWS infrastructure with Terraform.
- Configuring VPC networking, public subnets, routing, and security groups.
- Using EC2 user data to automate instance configuration.
- Connecting to AWS instances using SSH.
- Transferring files between Linux systems using SCP.
- Troubleshooting application and network connectivity.
- Managing AWS infrastructure lifecycle with Terraform.

## Project Outcome

Successfully built and deployed a containerized Python web application to AWS EC2.

This project reinforced how application development, Docker, Linux administration, AWS infrastructure, and Infrastructure as Code work together in a practical cloud deployment workflow.

The AWS infrastructure was destroyed after testing was completed.

########################################

## CI/CD Automation with GitHub Actions

### Overview

After developing and deploying the containerized Python web application, I expanded the project by implementing a CI/CD workflow using GitHub Actions.

The goal was to automate Docker image builds whenever application changes are pushed to the GitHub repository. This provides an automated way to verify that the application can successfully be packaged into a Docker image.

### Technologies Used

- **Docker:** Built and packaged the Python web application into a container image.
- **GitHub Actions:** Automated the Docker image build process.
- **GitHub:** Hosted the project source code and triggered workflow execution.
- **YAML:** Defined the GitHub Actions workflow.
- **Ubuntu:** Provided the Linux-based environment for automated builds.

### Workflow Configuration

Created the following workflow file:
.github/workflows/docker-ci.yml


Configured the workflow to automatically execute when changes are pushed to the main branch.

The workflow runs on a GitHub-hosted Ubuntu runner and performs the following steps:

1. **Checkout Repository:** Retrieves the application source code from GitHub.
2. **Build Docker Image:** Uses the project's Dockerfile to build an image named aws-docker-webapp.
3. **Verify Docker Image:** Runs docker images aws-docker-webapp to display and verify the newly built image.

### Docker Build Process

The GitHub Actions workflow uses the following command to build the Docker image:
docker build -t aws-docker-webapp .

The command uses the repository's root directory as the Docker build context and the Dockerfile to define the image configuration.


### Workflow Results

Successfully configured and executed the Docker CI workflow through GitHub Actions.

The workflow completed all three stages successfully:

- Repository checkout
- Docker image build
- Docker image verification

This demonstrated the ability to:
- Automate Docker image builds through GitHub Actions.
- Configure CI workflows using YAML.
- Work with GitHub-hosted Linux runners.
- Troubleshoot Dockerfile configuration and build-context issues.
- Integrate container build verification into a development workflow.

### Skills Demonstrated

- Docker and containerization
- Dockerfile configuration
- Python application containerization
- Git and GitHub
- GitHub Actions
- CI/CD automation
- YAML workflow configuration
- Linux-based build environments
- Docker build troubleshooting

**Note:** This workflow currently builds and verifies the Docker image but does not publish it to a container registry or automatically deploy it to AWS. The image is built on a temporary GitHub-hosted runner for CI verification.
