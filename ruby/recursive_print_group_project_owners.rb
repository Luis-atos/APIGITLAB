#!/usr/bin/env ruby

require 'gitlab'
require 'dotenv/load'

# Traverse group projects/subgroups and print project owners

# Usage: provide group id, or prompt on run
# ./recursive_print_group_project_owners.rb 55
# or
# ./recursive_print_group_project_owners.rb
# Enter Group ID: 55

# Example Output:
# Enter Group ID: 55
# Parent Group Owners
# root
# Parent Project Owners
# ruby(54):code-quality/ruby
#  - Owners:
# Subgroup Owners

parent_group_id = if $ARGV.empty?
                    print 'Enter Group ID: '
                    gets.chomp
                  else
                    $ARGV.first
                  end

client = Gitlab.client(
  endpoint: ENV['GITLAB_URL'],
  private_token: ENV['GITLAB_TOKEN'],
  httparty: { verify: false }
)

def print_project_membership(client, projects)
  projects.auto_paginate do |project|
    puts "#{project.name}(#{project.id}):#{project.path_with_namespace}"
    project_members = client.team_members(project.id)
    owners = project_members.map do |user|
      next unless user.access_level == 50

      user.username
    end.compact.join(', ')

    puts " - Owners: #{owners}"
  end
end

def print_subgroup_membership(client, subgroups)
  subgroups.auto_paginate do |subgroup|
    puts "#{subgroup.name} Subgroup Owners"
    subgroup_members = client.group_members(subgroup.id)
    owners = subgroup_members.map do |user|
      next unless user.access_level == 50

      user.username
    end.compact.join(', ')

    puts " - Owners: #{owners}"
    subgroup_projects = client.group_projects(subgroup.id)
    print_project_membership(client, subgroup_projects) if subgroup_projects
    subgroup_subgroups = client.group_subgroups(subgroup.id)
    print_subgroup_membership(client, subgroup_subgroups) if subgroup_subgroups
  end
end

parent_group_members = client.group_members(parent_group_id)

# Print Parent Group Owners
puts 'Parent Group Owners'
parent_group_members.auto_paginate do |member|
  next unless member.access_level == 50

  puts member.username
end

parent_group_projects = client.group_projects(parent_group_id)

# Print Parent Group Project Owners
puts 'Parent Project Owners'
print_project_membership(client, parent_group_projects)

parent_group_subgroups = client.group_subgroups(parent_group_id)

puts 'Subgroup Owners'
if parent_group_subgroups
  print_subgroup_membership(client, parent_group_subgroups)
end
