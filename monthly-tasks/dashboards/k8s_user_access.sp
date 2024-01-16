dashboard "kubernetes-access" {
  title = "List of Users and Roles with Access to Kubernetes Cluster"

  table {
    query = query.k8s_access
    }

}

query "k8s_access" {
  sql = <<-EOQ
    select
      name,
      namespace,
      data ->> 'mapAccounts' as accounts,
      data ->> 'mapRoles' as roles,
      data ->> 'mapUsers' as usernames
    from
      kubernetes_config_map
    where
      name = 'aws-auth' AND namespace = 'kube-system';
    EOQ
  }
