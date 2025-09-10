#------- Dev Account -------#
vpc_cidr         = "10.1.0.0/16"
pub_subnet_cidrs = ["10.1.0.0/20", "10.1.16.0/20"]
pri_subnet_cidrs = ["10.1.32.0/20", "10.1.48.0/20","10.1.64.0/20","10.1.80.0/20"]
pub_subnet_count = 2
pri_subnet_count = 4
azs              = ["us-east-1a", "us-east-1b","us-east-1c","us-east-1d"]
nat_eip_count    = 3



sparc_vpc_ids = {
  "vpc1" = {
    id     = "vpc-0f6e81e61274f7089"
    region = "us-east-1"
  }
  "vpc2" = {
    id     = "vpc-014e0aff70837daaa"
    region = "us-east-1"
  }
  "vpc3" = {
    id     = "vpc-0be420af0abd5547b"
    region = "us-east-1"
  }
}