variable "sparc_vpc_ids" {
  description = "A map of VPC IDs and their regions for associating with the private Route53 zone."
  type = map(object({
    id     = string
    region = string
  }))
}