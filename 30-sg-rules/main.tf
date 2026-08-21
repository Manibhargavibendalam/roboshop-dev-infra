

# #Frontend accepting traffic from frontend ALB
# resource "aws_security_group_rule" "frontend_frontend_alb"{
#     type = "ingress"
#     security_group_id = module.sg[9].sg_id #frontend sg id
#     source_security_group_id = module.sg[11].sg_id #frontend alb sg id
#     from_port = 80 
#     protocol = "tcp"
#     to_port = 80
# }


resource "aws_security_group_rule" "backend_alb_bastion"{
    type = "ingress"
    security_group_id = local.backend_alb_sg_id
    source_security_group_id = local.bastion_sg_id
    from_port = 80
    protocol = "tcp"
    to_port = 80
}

resource "aws_security_group_rule" "bastion_laptop"{
    type = "ingress"
    security_group_id = local.bastion_sg_id
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    protocol = "tcp"
    to_port = 22
}

resource "aws_security_group_rule" "mongodb_bastion"{
    type = "ingress"
    security_group_id = local.mongodb_sg_id
    source_security_group_id = local.bastion_sg_id
    from_port = 22
    protocol = "tcp"
    to_port = 22
}

resource "aws_security_group_rule" "redis_bastion"{
    type = "ingress"
    security_group_id = local.redis_sg_id
    source_security_group_id = local.bastion_sg_id
    from_port = 22
    protocol = "tcp"
    to_port = 22
}

resource "aws_security_group_rule" "rabbitmq_bastion"{
    type = "ingress"
    security_group_id = local.rabbitmq_sg_id
    source_security_group_id = local.bastion_sg_id
    from_port = 22
    protocol = "tcp"
    to_port = 22
}

resource "aws_security_group_rule" "mysql_bastion"{
    type = "ingress"
    security_group_id = local.mysql_sg_id
    source_security_group_id = local.bastion_sg_id
    from_port = 22
    protocol = "tcp"
    to_port = 22
}

resource "aws_security_group_rule" "catalogue_bastion"{
    type = "ingress"
    security_group_id = local.catalogue_sg_id
    source_security_group_id = local.bastion_sg_id
    from_port = 22
    protocol = "tcp"
    to_port = 22
} 

resource "aws_security_group_rule" "mongodb_catalogue"{
    type = "ingress"
    security_group_id = local.mongodb_sg_id
    source_security_group_id = local.catalogue_sg_id
    from_port = 27017
    protocol = "tcp"
    to_port = 27017
} 

#this is for component module
# mongodb should accept connection from the user
resource "aws_security_group_rule" "mongodb_user"{
    type = "ingress"
    security_group_id = local.mongodb_sg_id
    source_security_group_id = local.user_sg_id
    from_port = 27017
    protocol = "tcp"
    to_port = 27017
} 
resource "aws_security_group_rule" "catalogue_backend_alb"{
    type = "ingress"
    security_group_id = local.catalogue_sg_id
    source_security_group_id = local.backend_alb_sg_id
    from_port = 8080
    protocol = "tcp"
    to_port = 8080
}

resource "aws_security_group_rule" "frontend_alb_public"{
    type = "ingress"
    security_group_id = local.frontend_alb_sg_id
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 443
    protocol = "tcp"
    to_port = 443
}

# this are also for the component module ..
# actually this rules will be used for the all the modules
# redis should accept conncetion from the user
resource "aws_security_group_rule" "redis_user"{
    type = "ingress"
    security_group_id = local.redis_sg_id
    source_security_group_id = local.user_sg_id
    from_port = 6379
    protocol = "tcp"
    to_port = 6379
}


#redis should accept connection fron the user

resource "aws_security_group_rule" "redis_cart"{
    type = "ingress"
    security_group_id = local.redis_sg_id
    source_security_group_id = local.cart_sg_id
    from_port = 6379
    protocol = "tcp"
    to_port = 6379
}


# mysql should accept connection from the shipping ....
resource "aws_security_group_rule" "mysql_shipping"{
    type = "ingress"
    security_group_id = local.mysql_sg_id
    source_security_group_id = local.shipping_sg_id
    from_port = 3306
    protocol = "tcp"
    to_port = 3306
}

#rabbitmq should accept connection from payment

resource "aws_security_group_rule" "rabbitmq_payment"{
    type = "ingress"
    security_group_id = local.rabbitmq_sg_id
    source_security_group_id = local.payment_sg_id
    from_port = 5672
    protocol = "tcp"
    to_port = 5672
}

#user should accept connection from backend alb
resource "aws_security_group_rule" "user_backend_alb"{
    type = "ingress"
    security_group_id = local.user_sg_id
    source_security_group_id = local.backend_alb_sg_id
    from_port = 8080
    protocol = "tcp"
    to_port = 8080
}

resource "aws_security_group_rule" "cart_backend_alb"{
    type = "ingress"
    security_group_id = local.cart_sg_id
    source_security_group_id = local.backend_alb_sg_id
    from_port = 8080
    protocol = "tcp"
    to_port = 8080
}

resource "aws_security_group_rule" "shipping_backend_alb"{
    type = "ingress"
    security_group_id = local.shipping_sg_id
    source_security_group_id = local.backend_alb_sg_id
    from_port = 8080
    protocol = "tcp"
    to_port = 8080
}

resource "aws_security_group_rule" "payment_backend_alb"{
    type = "ingress"
    security_group_id = local.payment_sg_id
    source_security_group_id = local.backend_alb_sg_id
    from_port = 8080
    protocol = "tcp"
    to_port = 8080
}



# when we see documentation there is a relation between cart and catalogue..
# so we need to establish the connection

resource "aws_security_group_rule" "catalogue_cart"{
    type = "ingress"
    security_group_id = local.catalogue_sg_id
    source_security_group_id = local.cart_sg_id
    from_port = 8080
    protocol = "tcp"
    to_port = 8080
}

#dependency between cart ans shipping

resource "aws_security_group_rule" "cart_shipping"{
    type = "ingress"
    security_group_id = local.cart_sg_id
    source_security_group_id = local.shipping_sg_id
    from_port = 8080
    protocol = "tcp"
    to_port = 8080
}

resource "aws_security_group_rule" "user_payment"{
    type = "ingress"
    security_group_id = local.user_sg_id
    source_security_group_id = local.payment_sg_id
    from_port = 8080
    protocol = "tcp"
    to_port = 8080
}

resource "aws_security_group_rule" "cart_payment"{
    type = "ingress"
    security_group_id = local.cart_sg_id
    source_security_group_id = local.payment_sg_id
    from_port = 8080
    protocol = "tcp"
    to_port = 8080
}


#backend alb should accept connection from frontend
resource "aws_security_group_rule" "backend_alb_frontend"{
    type = "ingress"
    security_group_id = local.backend_alb_sg_id
    source_security_group_id = local.frontend_alb_sg_id
    from_port = 80
    protocol = "tcp"
    to_port = 80
}

# frontend should accept connection from frontend alb
resource "aws_security_group_rule" "frontend_frontend_alb"{
    type = "ingress"
    security_group_id = local.frontend_sg_id
    source_security_group_id = local.frontend_alb_sg_id
    from_port = 80
    protocol = "tcp"
    to_port = 80
}


resource "aws_security_group_rule" "user_bastion"{
    type = "ingress"
    security_group_id = local.user_sg_id
    source_security_group_id = local.bastion_sg_id
    from_port = 22
    protocol = "tcp"
    to_port = 22
}

resource "aws_security_group_rule" "cart_bastion"{
    type = "ingress"
    security_group_id = local.cart_sg_id
    source_security_group_id = local.bastion_sg_id
    from_port = 22
    protocol = "tcp"
    to_port = 22
}

resource "aws_security_group_rule" "shipping_bastion"{
    type = "ingress"
    security_group_id = local.shipping_sg_id
    source_security_group_id = local.bastion_sg_id
    from_port = 22
    protocol = "tcp"
    to_port = 22
}

resource "aws_security_group_rule" "payment_bastion"{
    type = "ingress"
    security_group_id = local.payment_sg_id
    source_security_group_id = local.bastion_sg_id
    from_port = 22
    protocol = "tcp"
    to_port = 22
}

resource "aws_security_group_rule" "frontend_bastion"{
    type = "ingress"
    security_group_id = local.frontend_sg_id
    source_security_group_id = local.bastion_sg_id
    from_port = 22
    protocol = "tcp"
    to_port = 22
}