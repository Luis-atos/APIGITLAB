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

# Search for everything authenticating user has access to
ready = client.user_merge_requests(state: 'opened').select do |mr|
  # Find relevant project info
  project = client.project(mr.project_id)
  puts "#{project.name_with_namespace}(#{project.id}):"

  # Check merge conflicts
  puts "\tGit Merge Status: #{mr.merge_status}"

  # Collect Pipeline information
  pipeline = client.commit_status(mr.project_id, mr.sha).map(&:status)
  puts "\tPipeline: #{pipeline.first}"

  # Check MR Approvers Configuration
  approved = client.merge_request_approvals(mr.project_id, mr.iid).approved
  puts "\tApproved: #{approved}"

  # If all match include
  pipeline.include?('success') && approved && mr.merge_status == 'can_be_merged'
end

# Ready to Merge Count
puts ready.count
