variable "vpc_cidr" {
 default ="10.0.0.0/16"
}
variable "public_subnets" {
  type = list(string)
  default = "10.0.1.0/24"
}
