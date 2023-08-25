resource "aws_vpc_peering_connection" "vpc_a_to_vpc_b" {
  peer_vpc_id = module.vpc-a.vpc_id
  vpc_id      = module.vpc-b.vpc_id
  auto_accept = true
  tags = {
    Name = "vpc-peering-a-to-b"
  }
}

resource "aws_vpc_peering_connection" "vpc_a_to_vpc_c" {
  peer_vpc_id = module.vpc-a.vpc_id
  vpc_id      = module.vpc-c.vpc_id
  auto_accept = true
  tags = {
    Name = "vpc-peering-a-to-c"
  }
}

resource "aws_vpc_peering_connection" "vpc_b_to_vpc_c" {
  peer_vpc_id = module.vpc-b.vpc_id
  vpc_id      = module.vpc-c.vpc_id
  auto_accept = true
  tags = {
    Name = "vpc-peering-b-to-c"
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

resource "aws_route" "peering_routes_vpc_a_vpc_b_peering" {
  count                     = length(data.aws_route_tables.rts-vpc-a.ids)
  route_table_id            = tolist(data.aws_route_tables.rts-vpc-a.ids)[count.index]
  destination_cidr_block    = "10.1.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_a_to_vpc_b.id
  depends_on = [ module.vpc-a, module.vpc-b ]
}

resource "aws_route" "peering_routes_vpc_a_vpc_c_peering" {
  count                     = length(data.aws_route_tables.rts-vpc-a.ids)
  route_table_id            = tolist(data.aws_route_tables.rts-vpc-a.ids)[count.index]
  destination_cidr_block    = "10.2.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_a_to_vpc_c.id
  depends_on = [ module.vpc-a, module.vpc-c ]
}

resource "aws_route" "peering_routes_vpc_b_vpc_a_peering" {
  count                     = length(data.aws_route_tables.rts-vpc-b.ids)
  route_table_id            = tolist(data.aws_route_tables.rts-vpc-b.ids)[count.index]
  destination_cidr_block    = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_a_to_vpc_b.id
  depends_on = [ module.vpc-b, module.vpc-a ]
}
resource "aws_route" "peering_routes_vpc_b_vpc_c_peering" {
  count                     = length(data.aws_route_tables.rts-vpc-b.ids)
  route_table_id            = tolist(data.aws_route_tables.rts-vpc-b.ids)[count.index]
  destination_cidr_block    = "10.2.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_b_to_vpc_c.id
  depends_on = [ module.vpc-b, module.vpc-c ]
}

resource "aws_route" "peering_routes_vpc_c_vpc_a_peering" {
  count                     = length(data.aws_route_tables.rts-vpc-c.ids)
  route_table_id            = tolist(data.aws_route_tables.rts-vpc-c.ids)[count.index]
  destination_cidr_block    = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_a_to_vpc_c.id
  depends_on = [ module.vpc-a, module.vpc-c ]
}
resource "aws_route" "peering_routes_vpc_c_vpc_b_peering" {
  count                     = length(data.aws_route_tables.rts-vpc-c.ids)
  route_table_id            = tolist(data.aws_route_tables.rts-vpc-c.ids)[count.index]
  destination_cidr_block    = "10.1.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_b_to_vpc_c.id
  depends_on = [ module.vpc-c, module.vpc-b ]
}

