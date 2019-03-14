#!/usr/bin/env ruby

# Update a project with new visibility level

require 'gitlab'
require 'dotenv/load'

unless $ARGV.count == 2
  puts "Usage: #{$PROGRAM_NAME} <project id> <public/private/internal>"
  exit
end

project_id, visibility = $ARGV

client = Gitlab.client(
  endpoint: ENV['GITLAB_URL'],
  private_token: ENV['GITLAB_TOKEN'],
  httparty: { verify: false }
)

client.edit_project(project_id, visibility: visibility)
