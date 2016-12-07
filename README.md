# Library Simplified Ansible Playbook for AWS Deployment
This [Ansible playbook](http://docs.ansible.com/ansible/) deploys a [Library Simplified circulation server](https://github.com/NYPL-Simplified/circulation/) on Amazon Web Services.

## Purpose and Goals
This project aims to provide fully automated Library Simplified deployments to AWS. The overall goal is to lower the barrier to entry and increase the chances of success for libraries that wish to set up their own instance of Library Simplified. The current development focus is on (1) minimizing the need to manually create AWS resources, (2) automating all Linux OS configuration prerequisites, and (3) automating code deployment and the creation of the `config.json` file. See below for current status on these goals.

## Current Status
This playbook is in the preliminary proof-of-concept stage and is not suitable for production use. Below is a roadmap of tasks that can be automated with Ansible. Checked boxes indicate the tasks have been implemented in this playbook.

Circulation Server
- [x] Provision EC2 resources
  - [x] Provision EC2 server(s)
  - [x] Provision and EC2 SSH key pair
  - [ ] Create a dedicated AWS VPC (vitrual private cloud) for AWS networking
  - [ ] Create a dedicated EC2 security groups (AWS firewall)
  - [ ] Create a dedicated EC2 subnet
- [x] Provision RDS database instance
  - [x] PostgreSQL instance in RDS
  - [x] Create RDS security group with PostgreSQL ports open to the EC2 private IP
  - [ ] RDS subnet
- [x] Configure the Amazon Linux OS
  - [x] Install YUM package dependencies
  - [x] Create Python virtualenv
  - [x] Install pip requirements
  - [x] Install elasticsearch (work-in-progress)
- [x] Deploy the application code, config, and web server
  - [x] Clone the git repository w/submodules
  - [x] Write `config.json` to the server
  - [x] Write `uwsgi.ini` to the server
  - [x] Write nginx config `circulation.conf` to the server
  - [ ] Create uwsgi upstart process/service
  - [ ] Create system cron jobs
- [ ] Configure DNS with [Route 53](http://docs.ansible.com/ansible/route53_module.html)
- [ ] Provision AWS Elasticsearch Service (would replace local Elasticsearch)

Content Server
- [ ] Provision and deploy a Library Simplified local content server re-using AWS provisioning roles described above
  - [ ] Provision Amazon S3 buckets
  - [ ] Coordinate the `config.json` variables between the circulation server and content server

## What to Expect
After running this playbook, you will see the following in your AWS management console:
- 1 new EC2 instance running Amazon Linux
- 1 new RDS instance running PostgreSQL
- 1 new SSH Key Pair

The public IP of your new EC2 instance will serve a Libary Simplified circulation server OPDS feed over http.

## Requirements
- Linux or macOS for the control (administrator's local) machine, with Ansible installed
- GitHub SSH access from control (administrator's local) machine
- AWS AIM account with credentials that have been granted the following permissions:
  - AmazonEC2FullAccess
  - AmazonRDSFullAccess

The following could be automated in the future, but for now they must be created by hand prior to running the playbook:
- AWS subnet for EC2 instance
- AWS Security Group for EC2 instance (AWS firewall)
- AWS Security Group for RDS instance (AWS firewall)


## Installation
1. Install Ansible according to the instructions for the OS of the control (administrator's local) machine
2. Install python-boto on the control (administrator's local) machine
3. Add a file named `.boto` to your home directory on the control (administrator's local) machine with the following:
```
[Credentials]
aws_access_key_id = YOUR_AWS_ACCESS_KEY
aws_secret_access_key = YOUR_AWS_SECRET_ACCESS_KEY
```
4. Clone this repository to the control (administrator's local) machine
5. Copy the file `circulation-settings.sample` to a new file named `circulation-settings.yml`. Edit the file according to the steps below.

## Configuration
1. Fill out the required variables in `circulation-server.yml`

## Running the Playbook
To run the playbook, `cd` into the repository and run:

```ansible-playbook -vv -i localhost circulation-server.yml```
