resource "aws_instance" "myinstance" {
    for_each=tomap({
        instance_type_micro = "t2.micro"
        instance_type_small = "t2.small"
    })
    ami           = data.aws_ami.ubuntu.id
    instance_type = each.value
  
}
output "ec2_public_ip" {
    value ={
        for key,instance in aws_instance.myinstance: key=>instance.public_ip
    }
  
}