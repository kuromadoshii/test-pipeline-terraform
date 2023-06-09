resource "aws_key_pair" "key" {
  key_name   = "aws_key"
  public_key = var.aws_pub_key
}
resource "aws_instance" "vm" {
  ami                         = "ami-0747e613a2a1ff483"
  instance_type               = "t3.nano"
  key_name                    = aws_key_pair.key.key_name
  subnet_id                   = data.terraform_remote_state.vpc.outputs.subnet_id
  vpc_security_group_ids      = [data.terraform_remote_state.vpc.outputs.security_group_id]
  associate_public_ip_address = true

  tags = {
    "Name" = "vm-terraform"
  }
}