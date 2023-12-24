# | DevOps Project | GitHub+Jenkins+Terraform+Ansible+EC2

In this project we have created a pipeline which will create one ec2 instance in AWS cloud and after creating that ec2 instance we will install any kind of application like Apache server or any other as per requirement 

First of all I will create Pipeline with the help of Jenkins so our pipeline will fetch the code from the GitHub and fetch it to the server and then  Jenkins  will create one ec2 instance and after creating that ec2 instance will install the application like Apache server and the terraform on the ec2. 




## Steps

 we will create ec2 and insatll jenkins which act as Master node 

then craeted all the file using VS code and push that code to github

then we have opened port 8080 in SG and open the jenkins sever using public ip /8080

in the jenkins we have created freestyle project 
 
now in SCM 
click on Git paste the URL of your project

credentails not required because we are using public repo

now branch will be */Main

before this open terminal and install git 

```bash
  sudo yum install git
```

then paste the jenkins file on build Steps 
select :
Execute shell


paste below cmd on jenkins only terraform file then will exetuse 
 ansible 

```bash
  #!/bin/bash
set -xe

cd terraform

sed -i "s/server_name/${SERVER_NAME}/g" backend.tf
export TF_VAR_name=${SERVER_NAME}

terraform init
terraform plan
terraform $TERRAFORM_ACTION -auto-approve
```

then select
This project is parameterized

* choice parameter

name  TERRAFORM_ACTION

apply 
destroy

* string parameter

name SERVER_NAME


* Build Environment 

Delete Workspace before build starts

goto dashboard manage jenkins plugins add rebuild restart

--------------------------------------------------------
now go back to terminal 

insall ansible and terraform

now now create yaml file on /opt/inventory/

```bash
  plugin: aws_ec2


  regions:
    - us-east-1
  filters:

    tag:Environment: dev
```

 ansible-inventory -i /opt/ansible/inventory/aws_ec2.yml  --list

host will reflect 

cd /etc/ansible
sudo vi ansible.cfg


add below on file 

inventory       = /opt/ansible/inventory/aws_ec2.yml
host_key_checking = False

[inventory]

enable_plugins = aws_ec2


we will create the pem key file

sudo vi ap-south.pem

ls
ansible.cfg  ap-south.pem    hosts  index.html   roles

go back to jecnkin run the pipline 

successful 

now add 

```bash
#!/bin/bash
set -xe

cd terraform

sed -i "s/server_name/${SERVER_NAME}/g" backend.tf
export TF_VAR_name=${SERVER_NAME}

terraform init
terraform plan
terraform $TERRAFORM_ACTION -auto-approve

if [ $TERRAFORM_ACTION = "destroy" ]; then
	exit 0
else
	cd ../Ansible
	ansible-playbook -i /opt/ansible/inventory/aws_ec2.yaml apache.yaml 
fi
```

 
craete and add admin role to main jenkins server

craete bucket in s3 with same name you mentioned on terraform file

you can refer video 

https://www.youtube.com/watch?v=Wgij-P2d9xI



## Authors

- [@roshanwaghmare](https://github.com/roshanwaghmare)








