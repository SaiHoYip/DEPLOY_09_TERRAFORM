resource "aws_security_group" "db_SG" {
  name        = "db_SG"
  description = "security group for load balancer"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TCP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_security_group.allow_tcp.id]
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = 20
  engine               = "postgressSQL"
  engine_version       = "9.6.20-R1"
  instance_class       = "db.t3.micro"
  vpc_security_group_ids = [aws_security_group.db_SG]
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
