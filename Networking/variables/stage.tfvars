#------- Shared Shared -------#
vpc_cidr         = "10.4.0.0/16"
pub_subnet_cidrs = ["10.4.0.0/20", "10.4.16.0/20", "10.4.32.0/20", "10.4.48.0/20"]
pri_subnet_cidrs = ["10.4.64.0/20", "10.4.80.0/20", "10.4.96.0/20", "10.4.112.0/20"]
pub_subnet_count = 4
pri_subnet_count = 4
azs              = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
nat_eip_count    = 2

sparc_vpc_ids = {
  "vpc1" = {
    id     = "vpc-0de39eadc052b4bb8"
    region = "us-east-1"
  }
}