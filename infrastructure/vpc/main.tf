resource "aws_vpc" "vpc" {
  cidr_block         = "${var.aws_vpc_cidr}"
  enable_dns_support = true
  tags               = "${var.tags}"
}

resource "aws_subnet" "public_subnet" {
  count                   = "${length(var.aws_vpc_public_subnet_lists)}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.aws_vpc_public_subnet_lists[count.index]}"
  availability_zone       = "${element(var.aws_subnets_availability_zones, count.index%length(var.aws_subnets_availability_zones))}"
  map_public_ip_on_launch = true

  tags = "${var.tags}"
}

resource "aws_subnet" "private_subnet" {
  count                   = "${length(var.aws_vpc_private_subnet_lists)}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.aws_vpc_private_subnet_lists[count.index]}"
  availability_zone       = "${element(var.aws_subnets_availability_zones, count.index%length(var.aws_subnets_availability_zones))}"
  map_public_ip_on_launch = false

  tags = "${var.tags}"
}

resource "aws_internet_gateway" "igw" {
  count  = "${length(var.aws_vpc_public_subnet_lists) > 0 ? 1:0}"
  vpc_id = "${aws_vpc.vpc.id}"
  tags   = "${var.tags}"
}

resource "aws_eip" "nat" {
  vpc        = true
  tags       = "${var.tags}"
  depends_on = ["aws_internet_gateway.igw"]
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = "${aws_eip.nat.id}"
  count         = "${var.enable_nat_gateway}"
  subnet_id     = "${aws_subnet.public_subnet.0.id}"
  tags          = "${var.tags}"
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags   = "${var.tags}"
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags   = "${var.tags}"
}

resource "aws_route" "public-route" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.igw.id}"
}

resource "aws_route" "private-route" {
  route_table_id         = "${aws_route_table.private.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat_gateway.id}"
}

resource "aws_route_table_association" "public-route-table" {
  count          = "${length(var.aws_vpc_public_subnet_lists)}"
  subnet_id      = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private-route-table" {
  count          = "${length(var.aws_vpc_private_subnet_lists)}"
  subnet_id      = "${element(aws_subnet.private_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.private.id}"
}
