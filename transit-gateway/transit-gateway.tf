# locals {
#   region = "us-east-1"
# }

locals {
  region = "us-west-2"
}

module "tgw" {
  source  = "terraform-aws-modules/transit-gateway/aws"
  version = "~> 2.0"

  name        = "tgw-poc1"
  description = "Transit gateway in PoC1"

#   enable_auto_accept_shared_attachments = true

  vpc_attachments = {
    vpc-a = {
      vpc_id       = data.aws_vpc.vpc-a.id
      subnet_ids   = data.aws_subnets.sn-vpc-a.ids
      dns_support  = true
      ipv6_support = false

      tgw_routes = [
        {
          destination_cidr_block = "10.0.0.0/16"
        },
        # {
        #   blackhole = true
        #   destination_cidr_block = "40.0.0.0/20"
        # }
      ]
    },
    vpc-b = {
      vpc_id       = data.aws_vpc.vpc-b.id
      subnet_ids   = data.aws_subnets.sn-vpc-b.ids
      dns_support  = true
      ipv6_support = false

      tgw_routes = [
        {
          destination_cidr_block = "10.1.0.0/16"
        },
        # {
        #   blackhole = true
        #   destination_cidr_block = "40.0.0.0/20"
        # }
      ]
    },
    vpc-c = {
      vpc_id       = data.aws_vpc.vpc-c.id
      subnet_ids   = data.aws_subnets.sn-vpc-c.ids
      dns_support  = true
      ipv6_support = false

      tgw_routes = [
        {
          destination_cidr_block = "10.2.0.0/16"
        },
        # {
        #   blackhole = true
        #   destination_cidr_block = "40.0.0.0/20"
        # }
      ]
    },
  }

  

#   ram_allow_external_principals = true
#   ram_principals = [779730081174]

  tags = {
    Purpose = "PoC1 challenge"
  }
}

data "aws_route_tables" "rts-vpc-a" {
  vpc_id = data.aws_vpc.vpc-a.id
}

data "aws_route_tables" "rts-vpc-b" {
  vpc_id = data.aws_vpc.vpc-b.id
}

data "aws_route_tables" "rts-vpc-c" {
  vpc_id = data.aws_vpc.vpc-c.id
}

data "aws_subnets" "sn-vpc-a" {
    filter {
        name = "vpc-id"
        values = [data.aws_vpc.vpc-a.id]
    }
}

data "aws_subnets" "sn-vpc-b" {
    filter {
        name = "vpc-id"
        values = [data.aws_vpc.vpc-b.id]
    }
}

data "aws_subnets" "sn-vpc-c" {
    filter {
        name = "vpc-id"
        values = [data.aws_vpc.vpc-c.id]
    }
}

resource "aws_route" "vpc-a_to_tgw" {
  count                     = length(data.aws_route_tables.rts-vpc-a.ids)
  route_table_id            = tolist(data.aws_route_tables.rts-vpc-a.ids)[count.index]
  destination_cidr_block    = "10.0.0.0/8"
  transit_gateway_id = module.tgw.ec2_transit_gateway_id
  depends_on                = [data.aws_vpc.vpc-a, data.aws_vpc.vpc-b, data.aws_vpc.vpc-c]
}

resource "aws_route" "vpc-b_to_tgw" {
  count                     = length(data.aws_route_tables.rts-vpc-b.ids)
  route_table_id            = tolist(data.aws_route_tables.rts-vpc-b.ids)[count.index]
  destination_cidr_block    = "10.0.0.0/8"
  transit_gateway_id = module.tgw.ec2_transit_gateway_id
  depends_on                = [data.aws_vpc.vpc-a, data.aws_vpc.vpc-b, data.aws_vpc.vpc-c]
}

resource "aws_route" "vpc-c_to_tgw" {
  count                     = length(data.aws_route_tables.rts-vpc-c.ids)
  route_table_id            = tolist(data.aws_route_tables.rts-vpc-c.ids)[count.index]
  destination_cidr_block    = "10.0.0.0/8"
  transit_gateway_id = module.tgw.ec2_transit_gateway_id
  depends_on                = [data.aws_vpc.vpc-a, data.aws_vpc.vpc-b, data.aws_vpc.vpc-c]
}