
resource "aws_instance" "bastion-host" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = "subnet-055c41fce697f9cca"
  key_name = "RampUp-devops-santiago.santacruzr"
  user_data = <<-EOF
    #!/usr/bin/env bash
    sudo chmod -R a+rwx /tmp
    sudo apt-get update
    sudo apt-get install mysql-server -y
    sudo apt-get upgrade -y
    sudo apt-get install awscli -y
    sudo apt install software-properties-common
    sudo apt-add-repository --yes --update ppa:ansible/ansible
    sudo apt install ansible -y
  EOF
  

  volume_tags = {
    project     = var.instance_project,
    responsible = var.instance_responsile
  }

  tags = {
    Name        = var.bastion_host_name
  }
}


resource "null_resource" "connection_bastion" {
  connection {
    type     = "ssh"
    user     = "ubuntu"
    #private_key = file("/home/slow-time/RampUp-devops-santiagosantacruzr.pem") 
    private_key = file("/vagrant/RampUp-devops-santiagosantacruzr.pem") 
    host     = aws_instance.bastion-host.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "echo Connection is stablished",
      "cd /home/ubuntu/",
      "sudo mkdir ansible_repo",
    ]
  }
  depends_on = [ aws_instance.bastion-host ]
}
resource "null_resource" "files_to_bastion" {
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("/vagrant/RampUp-devops-santiagosantacruzr.pem") 
    host     = aws_instance.bastion-host.public_ip
  }

  # provisioner "file" {
  #   source = "/mnt/c/Perficient/RampUp/Iac/new_user_credentials.csv"
  #   destination = "/home/ubuntu/new_user_credentials.csv"
  # } 

  provisioner "file" {
    #source = "/mnt/c/Perficient/RampUp/.env"
    source = "/vagrant/.env"
    destination = "/tmp/.env"
  }

  provisioner "file" {
    source = "/vagrant/ansible_repo"
    destination = "/tmp/ansible_repo"
  }

  depends_on = [ 
    aws_instance.bastion-host,
    null_resource.connection_bastion

   ]
}
resource "null_resource" "move_env" {
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("/vagrant/RampUp-devops-santiagosantacruzr.pem") 
    host     = aws_instance.bastion-host.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "cd /home/ubuntu/ansible_repo",
      "sudo mv /tmp/ansible_repo/* /home/ubuntu/ansible_repo/",
      "sudo mv /tmp/.env /home/ubuntu/ansible_repo/roles/web-servers/files",
      "sudo chown -R ubuntu:ubuntu /home/ubuntu/ansible_repo/",
    ]
  }
  depends_on = [ null_resource.files_to_bastion ]
}

