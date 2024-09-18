#CREATING VPC USING AWS RESOURCE:

resource "aws_vpc" "our-vpc" {
  cidr_block = var.vpc_config.cidr_block
  tags = {
    Name =  var.vpc_config.name

  }
}

resource "aws_subnet" "subnet" {
  vpc_id = aws_vpc.our-vpc.id
  for_each = var.config_subnet          #key={cidr, az} each.key, eacb.value
  cidr_block = each.value.cidr_block
  availability_zone = each.value.az

  tags = {
    name = each.key
  }

}


locals {
  public_subnet={
    #key={} if public is true in subnet
    for key, config in var.config_subnet : key => config if config.public
  }

  private_subnet={
    for key, config in var.config_subnet : key => config if !config.public
  }
}


#Internet gateway, if there is atleast one public subnet
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.our-vpc.id
  count = length(local.public_subnet) > 0 ? 1 : 0
}

#Creating routing table:
resource "aws_route_table" "route_table" {
  count = length(local.public_subnet) > 0 ? 1 : 0
  vpc_id= aws_vpc.our-vpc.id
  route {
    cidr_block="0.0.0.0/0"
    gateway_id=aws_internet_gateway.main[0].id
  }
}

resource "aws_route_table_association" "main" {
  for_each = local.public_subnet

  subnet_id = aws_subnet.subnet[each.key].id
  route_table_id = aws_route_table.route_table[0].id
  
}