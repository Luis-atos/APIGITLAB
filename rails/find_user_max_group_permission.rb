# Find the User
user = User.find_by_username 'user'

# Collect specific group
group = Group.find_by_full_path 'group'

# Output the Max permission
user.max_member_access_for_group group.id