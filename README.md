# Cloud Maintenance Tasks

## Introduction
This project aims to povide an automated approach to some of the maintencnace and compliance checks in AWS environments, as set out in the [Cloud Environment Maintenance Schedule](https://www.stack.io/whitepapers/cloud-environment-maintenance-schedule).
## Requirements

In order for the automated dashboards to be displayed, the following items need to be present in your environment:
1. Steampipe needs to be installed:
    - Installation instructions can be found [here](https://steampipe.io/downloads).

2. The Steampipe [AWS Plugin](https://hub.steampipe.io/plugins/turbot/aws) needs to be installed.

3. The Steampipe [Kubernetes Plugin](https://hub.steampipe.io/plugins/turbot/kubernetes) needs to be installed.

4. AWS Credentials need to be set. Instructions can be find [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html).
    - Export your AWS Profile containing the required permissions (full Read-Only Access is required)
    - E.g. ```export AWS_PROFILE=my-profile```

5. Set the ```kube-context``` to one with sufficient read permissions across the cluster. The ```kubeconfig``` file can automatically be updated for an AWS EKS cluster as per instructions [here](https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html). Full Read-Only permissions are required across the EKS cluster.
    - ```kubectl config get-contexts```
    - ```kubectl config set context <pre-configured existing context>```

## Usage

### For the Steampipe dashboards:
```
cd /monthly-tasks/dashboards
steampipe dashboard
```
Once the ```steampipe dashboard``` command has been issued, Steampipe automatically opens a window in your browser for for http://localhost:9194/

### For the bash script to get the AMI age in days:
```
cd scripts
./aws-ami-age-check.sh
```





