resource "aws_key_pair" "dove-key" {
  key_name   = "dovekey"
  public_key = file("dovekey.pub")
}
resource "aws_instance" "dove-int" {
  ami                    = var.AMI
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE
  key_name               = aws_key_pair.dove-key.key_name
  vpc_security_group_ids = ["sg-0d79c1dcfa1ecae06"]

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "remote-exec" {
    inline = [
        "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh"

    ]
  }

  connection {
    user        = var.USER
    private_key = file("dovekey")
    host        = self.public_ip
  }
}
