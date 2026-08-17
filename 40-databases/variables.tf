
variable "project_name" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}

variable "sg_names" {
    default = [
        #databases
        "mongodb","redis","mysql","rabbitmq",
        #backend
        "catalogue","user","cart","shipping","payment",
        # frontend
        "frontend",
        #bastion
        "bastion",
        #frontend load balancer
        "frontend_alb",
        #backend load balancer
        "backend_alb"
        ]
}

variable "zone_id"{
    default = "Z05991441T1HV11ZNW7DB"
}

variable "domain_name" {
  default = "manibhargavi2225.online"
}
