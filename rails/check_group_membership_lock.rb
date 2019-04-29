# Print out any groups that do not have the membership lock enabled\
# Uncomment out the group save to apply the change everywhere
puts 'Groups without Membership lock'
Group.all.each do |group|
  next if group.membership_lock

  puts "#{group.full_name} - #{group.web_url}"

  # group.membership_lock = true
  # group.save!
end
