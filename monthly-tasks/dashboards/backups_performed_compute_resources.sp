dashboard "ebs-volume-snapshots" {
  title = "EBS Volume Snapshots"
  table {
    query = query.ebs_snapshot_creation_date
    }
    
}

query "ebs_snapshot_creation_date" {
  sql = <<-EOQ
    select
      volume_id,
      snapshot_id,
      extract(day from (current_date - start_time)) as snapshot_age_days
    from
      aws_ebs_snapshot
  EOQ
}
