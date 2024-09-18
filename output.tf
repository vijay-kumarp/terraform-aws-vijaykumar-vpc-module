#VPC
output "vpc_output" {
  value = aws_vpc.our-vpc.id
}


locals {
  #to format the subnet ids which may be multiples in format of subnet
  public_subnet_output= {
    for key, config in local.public_subnet: key => {
        subnet_id= aws_subnet.subnet[key].id
        az= aws_subnet.subnet[key].availability_zone

    }

  }
  private_subnet_output= {
    for key, config in local.private_subnet: key =>{
        subnet_id= aws_subnet.subnet[key].id
        az = aws_subnet.subnet[key].availability_zone
    }

  }
}

#subnet:
output "public-subnets" {
  value = local.public_subnet_output
}

output "private-subnet" {
  value = local.private_subnet_output
}

