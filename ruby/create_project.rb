#!/usr/bin/env ruby

# Create a project in the user's namespace

# Usage: provide project name or prompt on run
# ./create_project.rb sweetname
# or
# ./create_project.rb
# Enter Project Name: sweetname

# Example Output
# ./create_project.rb ohboy
# Project Created: 58
# Administrator / ohboy
# https://gitlab/root/ohboy

require 'gitlab'
require 'dotenv/load'

project_name = if $ARGV.empty?
                 print 'Enter Project Name: '
                 gets.chomp
               else
                 $ARGV.first
               end

client = Gitlab.client(
  endpoint: ENV['GITLAB_URL'],
  private_token: ENV['GITLAB_TOKEN'],
  httparty: { verify: false }
)

project = client.create_project(project_name, description: 'Awesome project')

puts "Project Created: #{project.id}"
puts project.name_with_namespace
puts project.web_url
