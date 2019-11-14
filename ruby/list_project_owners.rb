#!/usr/bin/env ruby

require 'gitlab'
require 'dotenv/load'

client = Gitlab.client(
  endpoint: ENV['GITLAB_URL'],
  private_token: ENV['GITLAB_TOKEN'],
  httparty: { verify: false }
)

# GET /projects/:id/members/all
class Gitlab::Client
  # Defines methods related to projects.
  # @see https://docs.gitlab.com/ce/api/projects.html
  module Projects

    def all_team_members(project, options = {})
      get("/projects/#{url_encode project}/members/all", query: options)
    end

  end
end

client.projects.auto_paginate.each do |project|
  members = client.all_team_members(project.id)
  owners = members.map do |user|
    next unless user.access_level == 50

    user.username
  end.compact.join(', ')
  puts "#{project.path_with_namespace} - Owners: #{owners}"
end
