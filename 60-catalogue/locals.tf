locals{
    common_name_suffix = "${var.project_name}-${var.environment}"
    private_subnet_id = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]
    ami_id=data.aws_ami.joindevops.id
    common_tags = {
        Project    = var.project_name
        Environment = var.environment
        Terraform   = "true"
    }
}