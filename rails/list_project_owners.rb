Project.all.each do |project|
  owners = project.team_members.map do |user|
    next unless user.max_member_access_for_project(project.id) == 50

    user.username
  end.compact.join(', ')

  puts "#{project.path_with_namespace} - #{owners}"
end
