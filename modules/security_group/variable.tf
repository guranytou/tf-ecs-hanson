variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "from_port" {
  type = number
}

variable "to_port" {
  type = number
}

variable "protocol" {
  type = string
}

variable "source_security_group_id" {
  type    = string
  default = ""
}

variable "cidr_blocks" {
  type    = list(string)
  default = []
}