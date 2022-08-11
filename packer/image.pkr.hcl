packer {
	required_plugins {
		amazon = {
			version = ">= 0.0.1"
			source = "github.com/hashicorp/amazon"
		}
	}
}



source "amazon-ebs" "image" {
	ami_name             = "golden-image {{timestamp}}"
	ssh_private_key_file = "id_rsa"
	ssh_keypair_name     = "packer"
	instance_type        = "t2.micro"
	ssh_username         = "ec2-user"
	region               = "us-east-1"
	source_ami = "ami-090fa75af13c156b4"
	run_tags = {
		Name = "Packer instance for golden-image"
	}
}




build {
	sources = [
		"source.amazon-ebs.image"
	]
	provisioner "shell" {
		inline = [
			"echo Installing Telnet",
			"sudo yum install telnet -y"   #Change for ubuntu
		]
	}
}