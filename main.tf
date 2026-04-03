resource "aws_instance" "test_server" {
    ami = "ami-0ec10929233384c7f"
    instance_type = "t2.medium"
    key_name = "test"
    vpc_security_group_ids = [ aws_security_group.test.id ]
    subnet_id = aws_subnet.test-public_subent_01.id
    for_each = toset(["master", "slave"])
   tags = {
     Name = "${each.key}"
   }
}

resource "aws_security_group" "test" {
  name        = "test"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.test-vpc.id

  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "test"
  }
}

resource "aws_vpc" "test-vpc" {
       cidr_block = "10.1.0.0/16"
       tags = {
        Name = "test-vpc"
     }
   }

   //Create a Subnet 
resource "aws_subnet" "test-public_subent_01" {
    vpc_id = aws_vpc.test-vpc.id
    cidr_block = "10.1.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"
    tags = {
      Name = "test-public_subent_01"
    }
}

//Creating an Internet Gateway 
resource "aws_internet_gateway" "test-igw" {
    vpc_id = aws_vpc.test-vpc.id
    tags = {
      Name = "test-igw"
    }
}

// Create a route table 
resource "aws_route_table" "test-public-rt" {
    vpc_id = aws_vpc.test-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.test-igw.id
    }
    tags = {
      Name = "test-public-rt"
    }
}

// Associate subnet with route table

resource "aws_route_table_association" "test-rta-public-subent-1" {
    subnet_id = aws_subnet.test-public_subent_01.id
    route_table_id = aws_route_table.test-public-rt.id
}
