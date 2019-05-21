# Find the User
user = User.find_by_username 'dwalker'

# Collect specific project
project = Project.find_by_full_path 'root/merge'

# Output the Max permission
user.max_member_access_for_project project.id