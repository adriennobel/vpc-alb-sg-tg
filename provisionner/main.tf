provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "server1" {
  ami = "ami-0c614dee691cbbf37"
  instance_type = "t2.micro"
}

# generate keypair
resource "tls_private_key" "tls" {
  algorithm = "RSA"
  rsa_bits = 2048
}
resource "aws_key_pair" "key" {
  key_name = "provkey"
  public_key = tls_private_key.tls.public_key_openssh
}
# save key in local file
resource "local_file" "key1" {
  filename = "provkey.pem"
  content = tls_private_key.tls.private_key_pem
  file_permission = 400
}

resource "null_resource" "name" {
  provisioner "local-exec" {
    command = "echo ${aws_instance.server1.public_ip} > ip_address.txt"
  }
  connection {
    host = aws_instance.server1.public_ip
    type = "ssh"
    user = "ec2-user"
    private_key = file(local_file.key1.filename)
  }
  provisioner "file" {
    source = "ip_address.txt"
    destination = "/home/ec2-user/ip_address.txt"
  }
  provisioner "remote-exec" {
    inline = [ 
      "sudo yum install -y httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo chmod -R 666 /var/www/html",
      "sudo echo '<h1>Welcome to Terraform</h1>' > /var/www/html/index.html",
     ]
  }

  depends_on = [ aws_instance.server1, local_file.key1 ]
}
