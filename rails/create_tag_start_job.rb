# 1. Create a new tag
#   - https://docs.gitlab.com/ee/api/tags.html#create-a-new-tag
# 2. Search for the pipeline based on tags and sha. Get ID of the newest pipeline
#   - https://docs.gitlab.com/ee/api/pipelines.html#list-project-pipelines
# 3. List pipeline's jobs and filter for manual ones
#   - https://docs.gitlab.com/ee/api/jobs.html#list-pipeline-jobs
# 4. Play the jobs
#   - https://docs.gitlab.com/ee/api/jobs.html#play-a-job

# --------------------------------------------------
# Example .gitlab-ci.yml
# image: busybox:latest
# build1:
#   script:
#     - echo "Do your build here"
#   tags:
#     - docker
# deploy:
#   script:
#     - echo "Do your deploy here"
#   when: manual
#   tags:
#     - docker
# --------------------------------------------------

require 'gitlab'
require 'dotenv/load'

project_id = 56
tag_name = Time.now.strftime('%m/%e/%y_%H/%M')
source_branch = 'master'

# Create Tag, Get Commit ID
tag = client.create_tag(project_id, tag_name, source_branch)
sha = tag.to_h.dig('commit', 'id')

# Search for Pipeline
pipeline = client.pipelines(project_id, scope: :tags, sha: sha).first

# Find Manual Jobs
jobs = client.pipeline_jobs(project_id, pipeline.id, scope: :manual)

# Play Jobs
jobs.each do |job|
  client.job_play(project_id, job.id)
end
