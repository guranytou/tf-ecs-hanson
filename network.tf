#############################
# VPC
#############################

resource "aws_vpc" "sbcntr_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "sbcntfVpc"
  }
}

#############################
# Subnet - Public/Ingress
#############################

resource "aws_subnet" "sbcntr_subnet_pub_ingress_1a" {
  vpc_id     = aws_vpc.sbcntr_vpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "sbcntr-subnet-public-ingress-1a"
  }
}

resource "aws_subnet" "sbcntr_subnet_pub_ingress_1c" {
  vpc_id     = aws_vpc.sbcntr_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "sbcntr-subnet-public-ingress-1c"
  }
}

#############################
# Subnet - Private/Conainer
#############################

resource "aws_subnet" "sbcntr_subnet_pri_container_1a" {
  vpc_id     = aws_vpc.sbcntr_vpc.id
  cidr_block = "10.0.8.0/24"

  tags = {
    Name = "sbcntr-subnet-private-container-1a"
  }
}

resource "aws_subnet" "sbcntr_subnet_pri_container_1c" {
  vpc_id     = aws_vpc.sbcntr_vpc.id
  cidr_block = "10.0.9.0/24"

  tags = {
    Name = "sbcntr-subnet-private-container-1c"
  }
}

#############################
# Subnet - Private/DB
#############################

resource "aws_subnet" "sbcntr_subnet_pri_db_1a" {
  vpc_id     = aws_vpc.sbcntr_vpc.id
  cidr_block = "10.0.16.0/24"

  tags = {
    Name = "sbcntr-subnet-private-db-1a"
  }
}

resource "aws_subnet" "sbcntr_subnet_pri_db_1c" {
  vpc_id     = aws_vpc.sbcntr_vpc.id
  cidr_block = "10.0.17.0/24"

  tags = {
    Name = "sbcntr-subnet-private-db-1c"
  }
}

#############################
# Subnet - Public/Management
#############################

resource "aws_subnet" "sbcntr_subnet_pub_manage_1a" {
  vpc_id     = aws_vpc.sbcntr_vpc.id
  cidr_block = "10.0.240.0/24"

  tags = {
    Name = "sbcntr-subnet-public-management-1a"
  }
}

resource "aws_subnet" "sbcntr_subnet_pub_manage_1c" {
  vpc_id     = aws_vpc.sbcntr_vpc.id
  cidr_block = "10.0.241.0/24"

  tags = {
    Name = "sbcntr-subnet-public-management-1a"
  }
}

#############################
# Internet Gateway
#############################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.sbcntr_vpc.id
}

######################################
# Route Table(IGW - Public/Ingress)
######################################

resource "aws_route_table" "igw_ingress" {
  vpc_id = aws_vpc.sbcntr_vpc.id
}

resource "aws_route" "igw_ingress" {
  route_table_id         = aws_route_table.igw_ingress.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "igw_ingress_1a" {
  subnet_id      = aws_subnet.sbcntr_subnet_pub_ingress_1a.id
  route_table_id = aws_route_table.igw_ingress.id
}

resource "aws_route_table_association" "igw_ingress_1c" {
  subnet_id      = aws_subnet.sbcntr_subnet_pub_ingress_1c.id
  route_table_id = aws_route_table.igw_ingress.id
}

####################################################
# Route Table(Private/Container)
####################################################

resource "aws_route_table" "container" {
  vpc_id = aws_vpc.sbcntr_vpc.id
}

resource "aws_route_table_association" "container_1a" {
  subnet_id      = aws_subnet.sbcntr_subnet_pri_container_1a.id
  route_table_id = aws_route_table.container.id
}

resource "aws_route_table_association" "container_1c" {
  subnet_id      = aws_subnet.sbcntr_subnet_pri_container_1c.id
  route_table_id = aws_route_table.container.id
}

####################################################
# Route Table(Private/DB)
####################################################

resource "aws_route_table" "db" {
  vpc_id = aws_vpc.sbcntr_vpc.id
}

resource "aws_route_table_association" "db_1a" {
  subnet_id      = aws_subnet.sbcntr_subnet_pri_db_1a.id
  route_table_id = aws_route_table.db.id
}

resource "aws_route_table_association" "db_1c" {
  subnet_id      = aws_subnet.sbcntr_subnet_pri_db_1c.id
  route_table_id = aws_route_table.db.id
}

####################################################
# Route Table(Public/management)
####################################################

resource "aws_route_table" "management" {
  vpc_id = aws_vpc.sbcntr_vpc.id
}

resource "aws_route_table_association" "management_1a" {
  subnet_id      = aws_subnet.sbcntr_subnet_pub_manage_1a.id
  route_table_id = aws_route_table.management.id
}

resource "aws_route_table_association" "management_1c" {
  subnet_id      = aws_subnet.sbcntr_subnet_pub_manage_1c.id
  route_table_id = aws_route_table.management.id
}