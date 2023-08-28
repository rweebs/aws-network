# locals {
#   region = "us-east-1"
# }

locals {
  region = "us-west-2"
}

resource "aws_vpc_peering_connection" "vpc_a_to_vpc_b" {
  peer_vpc_id = data.aws_vpc.vpc-a.id
  vpc_id      = data.aws_vpc.vpc-b.id
  auto_accept = true
  tags = {
    Name = "vpc-peering-a-to-b"
  }
}

resource "aws_vpc_peering_connection" "vpc_a_to_vpc_c" {
  peer_vpc_id = data.aws_vpc.vpc-a.id
  vpc_id      = data.aws_vpc.vpc-c.id
  auto_accept = true
  tags = {
    Name = "vpc-peering-a-to-c"
  }
}

resource "aws_vpc_peering_connection" "vpc_b_to_vpc_c" {
  peer_vpc_id = data.aws_vpc.vpc-b.id
  vpc_id      = data.aws_vpc.vpc-c.id
  auto_accept = true
  tags = {
    Name = "vpc-peering-b-to-c"
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

resource "aws_route" "peering_routes_vpc_a_vpc_b_peering" {
  count                     = length(data.aws_route_tables.rts-vpc-a.ids)
  route_table_id            = tolist(data.aws_route_tables.rts-vpc-a.ids)[count.index]
  destination_cidr_block    = "10.1.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_a_to_vpc_b.id
  depends_on                = [data.aws_vpc.vpc-a, data.aws_vpc.vpc-b]
}

resource "aws_route" "peering_routes_vpc_a_vpc_c_peering" {
  count                     = length(data.aws_route_tables.rts-vpc-a.ids)
  route_table_id            = tolist(data.aws_route_tables.rts-vpc-a.ids)[count.index]
  destination_cidr_block    = "10.2.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_a_to_vpc_c.id
  depends_on                = [data.aws_vpc.vpc-a, data.aws_vpc.vpc-c]
}

resource "aws_route" "peering_routes_vpc_b_vpc_a_peering" {
  count                     = length(data.aws_route_tables.rts-vpc-b.ids)
  route_table_id            = tolist(data.aws_route_tables.rts-vpc-b.ids)[count.index]
  destination_cidr_block    = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_a_to_vpc_b.id
  depends_on                = [data.aws_vpc.vpc-b, data.aws_vpc.vpc-a]
}
resource "aws_route" "peering_routes_vpc_b_vpc_c_peering" {
  count                     = length(data.aws_route_tables.rts-vpc-b.ids)
  route_table_id            = tolist(data.aws_route_tables.rts-vpc-b.ids)[count.index]
  destination_cidr_block    = "10.2.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_b_to_vpc_c.id
  depends_on                = [data.aws_vpc.vpc-b, data.aws_vpc.vpc-c]
}

resource "aws_route" "peering_routes_vpc_c_vpc_a_peering" {
  count                     = length(data.aws_route_tables.rts-vpc-c.ids)
  route_table_id            = tolist(data.aws_route_tables.rts-vpc-c.ids)[count.index]
  destination_cidr_block    = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_a_to_vpc_c.id
  depends_on                = [data.aws_vpc.vpc-a, data.aws_vpc.vpc-c]
}
resource "aws_route" "peering_routes_vpc_c_vpc_b_peering" {
  count                     = length(data.aws_route_tables.rts-vpc-c.ids)
  route_table_id            = tolist(data.aws_route_tables.rts-vpc-c.ids)[count.index]
  destination_cidr_block    = "10.1.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_b_to_vpc_c.id
  depends_on                = [data.aws_vpc.vpc-c, data.aws_vpc.vpc-b]
}

