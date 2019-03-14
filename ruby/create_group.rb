#!/usr/bin/env ruby

# Create a new group

require 'gitlab'
require 'dotenv/load'

unless $ARGV.count >= 3
  puts "Usage: #{$PROGRAM_NAME} <name> <path> <description>"
  exit
end

name, path = $ARGV.shift(2)
description = $ARGV.join(' ')

client = Gitlab.client(
  endpoint: ENV['GITLAB_URL'],
  private_token: ENV['GITLAB_TOKEN'],
  httparty: { verify: false }
)

group = client.create_group(name, path, description: description)
group = client.create_group(name, path, visibility: visibility)

puts "Created Group: #{group.name}(#{group.id}) - #{group.web_url}"
