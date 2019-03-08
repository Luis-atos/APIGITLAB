#!/usr/bin/env ruby

# Show the number of users that are active in the last 7 days
# Show number of active users that username matches a certain pattern

require 'gitlab'
require 'dotenv/load'

client = Gitlab.client(
  endpoint: ENV['GITLAB_URL'],
  private_token: ENV['GITLAB_TOKEN'],
  httparty: { verify: false }
)

# Active Date to filter by
date = (Date.today - 7)

# Query for all users
users = client.users.auto_paginate

# Filter Users if their last acti
active = users.select do |user|
  next if user.last_activity_on.nil?

  date <= Date.parse(user.last_activity_on)
end

# Filter Active based on pattern 'svc'
service = active.select { |x| x.username =~ /svc/ }

# Output Details
puts "Total Active: #{active.count}"
puts "Total Active: #{service.count}"
