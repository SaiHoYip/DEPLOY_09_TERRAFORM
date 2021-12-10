resource "aws_db_instance" "default" {
  allocated_storage    = 20
  engine               = "postgressSQL"
  engine_version       = "9.6.20-R1"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "sai"
  password             = "abc12345"
  skip_final_snapshot  = true
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.frontend.id, aws_subnet.backend.id]

  tags = {
    Name = "My DB subnet group"
  }
}