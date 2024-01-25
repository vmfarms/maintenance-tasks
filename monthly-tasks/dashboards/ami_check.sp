# Currently unavaialbe as the Steampipe table aws_ec2_ami renders no values
#dashboard "ec2-ami-check" {
# title = "EC2 AMI Image Check"
#
#  table {
#    query = query.ami_in_use_date 
#    }
#}

query "ami_in_use_date" {
  sql = <<-EOQ
    select
      eci.instance_id,
      eci.image_id,
      eca.creation_date,
      extract(day from (current_date - eca.creation_date)) as ami_age_days
    from
      aws_ec2_instance as eci
    join
      aws_ec2_ami as eca on eci.image_id = eca.image_id
  EOQ
}