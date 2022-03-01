resource "aws_db_subnet_group" "db_subnet_terraform" {
   name       = var.db_subnet_terraform_name
   subnet_ids = [
     "subnet-038fa9d9a69d6561e",
     "subnet-0d74b59773148d704"
   ]
  
   tags = {
     Name = var.db_subnet_terraform_name,
     responsible = var.instance_project,
     project = var.instance_responsile
   }
}


resource "aws_db_instance" "movie-db-terraform" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0.27"
  instance_class       = "db.t2.micro"
  name                 = "movie_db"
  username             = "santiago"
  password             = "lycantropo"
  db_subnet_group_name = "${aws_db_subnet_group.db_subnet_terraform.id}"
  vpc_security_group_ids = [ 
    "${var.security_groups}",
    ]
  skip_final_snapshot  = true 
  apply_immediately = true

  tags = {
    Name = "terraform_database",
    responsible = var.instance_project,
    project = var.instance_responsile
  }
}
