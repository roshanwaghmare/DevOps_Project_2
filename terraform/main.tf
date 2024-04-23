
data "aws_ami" "amazon2" {
  most_recent = true

  owners = [ amazon ]
  filter {
    name = "name"
    values = [ "amzn2-ami-kernel-5.10-hvm-2.0.20240412.0-x86_64-gp2" ]
  }
  
}


resource "aws_instance" "dev_machine" {
  ami = data.aws_ami.amazon2.id
  instance_type = var.instance_type
  key_name = "jenkins"

  tags = {
    Environment = "dev"
    Name = "${var.name}-server"
  }
}
