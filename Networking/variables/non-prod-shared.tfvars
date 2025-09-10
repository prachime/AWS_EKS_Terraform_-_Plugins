#------- NonProd Shared -------#
vpc_cidr         = "10.3.0.0/16"
pub_subnet_cidrs = ["10.3.0.0/20", "10.3.16.0/20", "10.3.32.0/20", "10.3.48.0/20"]
pri_subnet_cidrs = ["10.3.64.0/20", "10.3.80.0/20", "10.3.96.0/20", "10.3.112.0/20"]
pub_subnet_count = 4
pri_subnet_count = 4
azs              = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
nat_eip_count    = 3

sparc_vpc_ids = {
  "vpc1" = {
    id     = "vpc-0426d1c49729f092a"
    region = "us-east-1"
  }
}