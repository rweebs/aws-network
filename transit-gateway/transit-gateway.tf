module "tgw" {
  source  = "terraform-aws-modules/transit-gateway/aws"
  version = "~> 2.0"

  name        = "tgw-poc1"
  description = "Transit gateway in PoC1"

#   enable_auto_accept_shared_attachments = true

  vpc_attachments = {
    vpc-a = {
      vpc_id       = module.vpc-a.vpc_id
      subnet_ids   = module.vpc-a.public_subnets
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
      vpc_id       = module.vpc-b.vpc_id
      subnet_ids   = module.vpc-b.public_subnets
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
      vpc_id       = module.vpc-c.vpc_id
      subnet_ids   = module.vpc-c.public_subnets
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
  vpc_id = module.vpc-a.vpc_id
}

data "aws_route_tables" "rts-vpc-b" {
  vpc_id = module.vpc-b.vpc_id
}

data "aws_route_tables" "rts-vpc-c" {
  vpc_id = module.vpc-c.vpc_id
}

resource "aws_route" "vpc-a_to_tgw" {
  count                     = length(data.aws_route_tables.rts-vpc-a.ids)
  route_table_id            = tolist(data.aws_route_tables.rts-vpc-a.ids)[count.index]
  destination_cidr_block    = "10.0.0.0/8"
  transit_gateway_id = module.tgw.ec2_transit_gateway_id
  depends_on                = [module.vpc-a, module.vpc-b, module.vpc-c]
}

resource "aws_route" "vpc-b_to_tgw" {
  count                     = length(data.aws_route_tables.rts-vpc-b.ids)
  route_table_id            = tolist(data.aws_route_tables.rts-vpc-b.ids)[count.index]
  destination_cidr_block    = "10.0.0.0/8"
  transit_gateway_id = module.tgw.ec2_transit_gateway_id
  depends_on                = [module.vpc-a, module.vpc-b, module.vpc-c]
}

resource "aws_route" "vpc-c_to_tgw" {
  count                     = length(data.aws_route_tables.rts-vpc-c.ids)
  route_table_id            = tolist(data.aws_route_tables.rts-vpc-c.ids)[count.index]
  destination_cidr_block    = "10.0.0.0/8"
  transit_gateway_id = module.tgw.ec2_transit_gateway_id
  depends_on                = [module.vpc-a, module.vpc-b, module.vpc-c]
}