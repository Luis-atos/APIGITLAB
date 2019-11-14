#!/usr/bin/env ruby

require 'gitlab'
require 'active_support/core_ext'

url = 'https://gitlab.example.com/api/v4'
token = 'secure_token'
p_id = '292'

client = Gitlab.client(
  endpoint: url,
  private_token: token,
  httparty: { verify: false }
)

# List Repositories
client.registry_repositories(p_id).each do |repo|
  # List Repo Tags
  client.registry_repository_tags(p_id, repo.id).auto_paginate.each do |tag|
    # Collect Tag Info
    details = client.registry_repository_tag(p_id, repo.id, tag.name)
    date = Date.parse(details.created_at)
    next unless date > 1.year.ago

    puts "#{details.path} - #{date}"
  end
end
