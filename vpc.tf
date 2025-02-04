# Fetch available availability zones
data "aws_availability_zones" "azs" {
  state = "available"
}

# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "proj-vpc"
  }
}

# Create public subnets
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = 2
  cidr_block              = "10.0.${count.index + 1}.0/24"
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet ${data.aws_availability_zones.azs.names[count.index]}"
  }
}

# Create private subnets
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.vpc.id
  count             = 2
  cidr_block        = "10.0.${count.index + 101}.0/24"
  availability_zone = data.aws_availability_zones.azs.names[count.index]
  tags = {
    Name = "Private Subnet ${data.aws_availability_zones.azs.names[count.index]}"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "proj-igw"
  }
}

# Create Elastic IPs for NAT Gateways
resource "aws_eip" "eip" {
  domain = "vpc"
  count  = 2
  tags = {
    Name = "eip-${count.index}"
  }
}

# Create NAT Gateways
resource "aws_nat_gateway" "nat" {
  count         = 2
  allocation_id = aws_eip.eip[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags = {
    Name = "nat-gateway-${data.aws_availability_zones.azs.names[count.index]}"
  }
}

# Create a public route table
resource "aws_route_table" "rt-public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public-route-table"
  }
}

# Associate public subnets with the public route table
resource "aws_route_table_association" "rtp" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.rt-public.id
}

# Create private route tables
resource "aws_route_table" "rt-private" {
  count  = 2
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }
  tags = {
    Name = "private-route-table"
  }
}

# Associate private subnets with the private route tables
resource "aws_route_table_association" "rtpri" {
  count          = 2
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.rt-private[count.index].id
}