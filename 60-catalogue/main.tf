#create EC2 instance

# resource "aws_instance" "catalogue" {
#     ami           = local.ami_id
#     instance_type = "t3.micro"
#     vpc_security_group_ids = [local.catalogue_sg_id]
#     subnet_id = local.private_subnet_id

#     tags = merge(
#         local.common_tags,
#         {
#             Name = "${local.common_name_suffix}-catalogue" #roboshop-dev-catalogue
#         }
#     )
# }

# #connect to instance using resource using remotw-exec provisioner through terraform_data

# resource "terraform_data" "catalogue"{
#     triggers_replace = [
#         aws_instance.catalogue.id
#     ]
#     connection {
#         type = "ssh"
#         user = "ec2-user"
#         password = "DevOps321"
#         host = aws_instance.catalogue.private_ip
#     }
    
#     #terraform copies this file to the catalogue server
#     provisioner "file" {
#             source = "catalogue.sh"
#             destination = "/tmp/catalogue.sh"
#     }

#     provisioner "remote-exec" {
#         inline =[
#             "chmod +x /tmp/catalogue.sh",
#             #"sudo sh /tmp/catalogue.sh"
#             "sudo sh /tmp/catalogue.sh catalogue dev"
#         ]
#     }
# }

# Create EC2 instance
resource "aws_instance" "catalogue" {
    ami = local.ami_id
    instance_type = "t3.micro"
    vpc_security_group_ids = [local.catalogue_sg_id]
    subnet_id = local.private_subnet_id
    
    tags = merge (
        local.common_tags,
        {
            Name = "${local.common_name_suffix}-catalogue" # roboshop-dev-mongodb
        }
    )
}

# Connect to instance using remote-exec provisioner through terraform_data
resource "terraform_data" "catalogue" {
  triggers_replace = [
    aws_instance.catalogue.id
  ]
  
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.catalogue.private_ip
  }

  # terraform copies this file to catalogue server
  provisioner "file" {
    source = "catalogue.sh"
    destination = "/tmp/catalogue.sh"
  }

  provisioner "remote-exec" {
    inline = [
        "chmod +x /tmp/catalogue.sh",
        # "sudo sh /tmp/catalogue.sh"
        "sudo sh /tmp/catalogue.sh catalogue ${var.environment}"
    ]
  }
}


#stop the instance to take image

resource "aws_ec2_instance_state" "stop_my_instance"{
    instance_id = aws_instance.my_instance.id
    state = "stopped"
    depends_on = [terraform_data.catalogue]
}

resource "aws_ami_from_instance" "catalogue" {
  name               = "${local.common_name_suffix}-catalogue-ami"
  source_instance_id = aws_instance.catalogue.id
  depends_on = [aws_ec2_instance_state.catalogue] #we are this because stopping don't interrupt it..if we dont use this stopping will interrupt this
}