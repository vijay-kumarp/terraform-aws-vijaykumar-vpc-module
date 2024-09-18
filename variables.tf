
# VARIABLE DECLARATION FOR CIDR AND NAME FOR VPC FROM USER:

variable "vpc_config" {
  description = "To get the CIDR BLOCK and name of VPC from user"
  type = object({
    cidr_block = string
    name = string
  })
  validation {
    condition = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "invalid CIDR format -${var.vpc_config.cidr_block}"
  }
}

# VARIABLE DECLARATION FOR CIDR AND AZ FOR SUBNETS:
variable "config_subnet" {
  #sub1={cidr=.., az=..} sub2={cidr=.., az=..} sub3={cidr=.. , az=..}
  description = "To get the cidr and available zones for subnets"
  type = map(object({
    cidr_block = string
    az = string
    public = optional(bool,false)
  }))
  validation {
    #sub1={cidr=}..sub2={cidr=}
    condition = alltrue([for config in var.config_subnet: can(cidrnetmask(config.cidr_block))])
    error_message = "invalid CIDR format"
  }
}