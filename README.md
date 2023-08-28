# POC Challange 1 Networking
# Prerequisites
1. Install Terraform
2. Add IAM User and generate Access Key
3. Put the credentials on ~/.aws/credentials below is the template

```
[default]
aws_access_key_id=AKIAZIN6EXAMPLE
aws_secret_access_key=62vwnfFpyEXAMPLE
```

## How to run
1. ```cd vpc```
2. ```terraform init```
3. ```terraform apply -auto-approve```
4. ```cd ..```
5. ```terraform init```
6. ```terraform apply -auto-approve```

OR
```bash run.sh```