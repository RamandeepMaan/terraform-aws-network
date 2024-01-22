// Define variables for module
variable "cidr_block" {
default = "10.10.0.0/16"  // For vpc
}

variable "subnet_az" {

default = [] // This should accept from list. Its null now.
type = list(string) // We want to accept list of strings.  
}

variable "subnet_cidr" {

  default = [] // This should accept from list. Its null now.
  type = list(string) // We want to accept list of strings.
}

// Define resources for module

resource "aws_vpc" "this" {
    cidr_block = var.cidr_block
  
}

resource "aws_subnet" "this" {
    count = length(var.subnet_cidr)
    vpc_id = aws_vpc.this.id
    cidr_block = var.subnet_cidr[count.index]
    availability_zone = var.subnet_az[count.index]
  
}

output "aws_vpc_id" {
    value = aws_vpc.this.id
  
}

output "subnet_ids" {
    value = aws_subnet.this[*].id // To print the output in list. The value of the count is tuple and would be printed with [*]
 
}
