dashboard "rds-volume-snapshots" {
  title = "RDS Volume Snapshots"
  table {
    query = query.rds_snapshot_creation_date
    }
    
}

query "rds_snapshot_creation_date" {
  sql = <<-EOQ
    select
      dbs.db_snapshot_identifier,
      dbs.allocated_storage as allocated_storage_in_GiB,
      EXTRACT(DAY FROM (current_date - dbs.create_time)) AS snapshot_age_days,
      dbi.db_instance_identifier,
      case 
        when dbi.db_instance_identifier is null then 'yes'
      else 'no'
       end as snapshot_orphaned
    from
      aws_rds_db_snapshot dbs
    left join
      aws_rds_db_instance dbi ON dbs.db_instance_identifier = dbi.db_instance_identifier
    order by
      dbs.db_snapshot_identifier;
  EOQ
}