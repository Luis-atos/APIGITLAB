# Active date to filter by
date = Date.today - 7

# Query for all users active since date
active_users = User.where("last_activity_on <= ?", date)
service_users = active_users.select { |x| x.username =~ /svc/ }

# Total active users
active_users.count

# Total service users
service_users.count
