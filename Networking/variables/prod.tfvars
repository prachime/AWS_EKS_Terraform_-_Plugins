#------- Prod Account -------#
vpc_cidr         = "10.2.0.0/16"
pub_subnet_cidrs = ["10.2.0.0/20", "10.2.16.0/20", "10.2.32.0/20", "10.2.48.0/20"]
pri_subnet_cidrs = ["10.2.64.0/20", "10.2.80.0/20", "10.2.96.0/20", "10.2.112.0/20"]
pub_subnet_count = 4
pri_subnet_count = 4
azs              = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
nat_eip_count    = 2