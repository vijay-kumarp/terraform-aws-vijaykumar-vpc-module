This is complete config file to work with this module

USAGE
'''
module "vpc" {
  source = "./modules/vpc"
  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "our-vpc"
  }
  config_subnet = {
    #key={cidr,az}
    public_subnet1 = {                     #creating 2 public subnet and 1 private subnet
      cidr_block = "10.0.0.0/24"
      az         = "ap-southeast-2a"
      public     = true
    }
    
    public_subnet2 = {
      cidr_block = "10.0.2.0/24"
      az         = "ap-southeast-2a"
      public     = true
    }

    private_subnet = {
      cidr_block = "10.0.1.0/24"
      az         = "ap-southeast-2b"
    }

  }
}
'''