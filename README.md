# terraform aws-vpc

## overview

This terraform module will creates an AWS VPC with give CIDR block. it also creates multiple subnets( Public and Private), and for Public subnets, it sets up INTERNET GATEWAY (IGW) and appropriate route tables.

## Features

- Creates an VPC with a specified CIDR BLOCK.
- Creates mulitple subnet both public and private.
- Creates an INTERNET GATEWAY for public subnet.
- Sets up route tables for public subnets.

## Usage
'''
module "vpc" {
  source = "./modules/vpc"
  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "Your-vpc-name"
  }
  config_subnet = {
    #key={cidr,az}
    public_subnet1 = {                     #creating 2 public subnet and 1 private subnet
      cidr_block = "10.0.0.0/24"
      az         = "ap-southeast-2a"
      #To set the subnet as public and default is private
      public     = true
    }
    
    private_subnet = {
      cidr_block = "10.0.1.0/24"
      az         = "ap-southeast-2b"
    }

  }
}

'''
