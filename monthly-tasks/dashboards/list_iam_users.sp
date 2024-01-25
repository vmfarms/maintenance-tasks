dashboard "iam-users-list" {
  title = "List of All IAM Users"

  table {           
      query = query.list_iam_users
    }
    
}
query "list_iam_users" {
  sql = <<-EOQ
    select
      name,
      user_id,
      arn,
      create_date,
      extract (day from (current_date - password_last_used)) as days_since_last_login,
      mfa_enabled
    from
      aws_iam_user
    order by 
      name;
  EOQ
}



