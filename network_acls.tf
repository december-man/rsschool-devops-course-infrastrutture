# Task 2: Networking Resources

# Deploy Public Network Access Control List
resource "aws_network_acl" "public_acl" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "public_acl"
  }
}

# Allow all inbound traffic for now
resource "aws_network_acl_rule" "ingress_allow_all" {
  network_acl_id = aws_network_acl.public_acl.id
  rule_number    = 200 # Choose a rule number that is higher than existing rules
  egress         = false
  protocol       = "-1" # -1 means all protocols
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

# Add egress rule to Public ACL to allow all outbound traffic
resource "aws_network_acl_rule" "egress_all" {
  network_acl_id = aws_network_acl.public_acl.id
  rule_number    = 201
  egress         = true
  protocol       = "-1" # All protocols allowed
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

# Associate Public Subnets with newly created Public Network ACL
resource "aws_network_acl_association" "public_acl_association_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  network_acl_id = aws_network_acl.public_acl.id
}

resource "aws_network_acl_association" "public_acl_association_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  network_acl_id = aws_network_acl.public_acl.id
}

# Private subnets should have "Deny All" rules by default. 
# They will be routed through the NAT instance to have access to the internet