#!/usr/bin/env ruby

# Update a group with new visibility level

require 'gitlab'
require 'dotenv/load'

unless $ARGV.count == 2
  puts "Usage: #{$PROGRAM_NAME} <group id> <public/private/internal>"
  exit
end

group_id, visibility = $ARGV

client = Gitlab.client(
  endpoint: ENV['GITLAB_URL'],
  private_token: ENV['GITLAB_TOKEN'],
  httparty: { verify: false }
)

client.edit_group(group_id, visibility: visibility)
