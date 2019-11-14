# gitlab-rails console
setting = ApplicationSetting.last
setting.elasticsearch_indexing = true
setting.elasticsearch_search = true
setting.elasticsearch_config = { 
  url: ['http://localhost:9200'],
  aws: false, aws_access_key: nil,
  aws_secret_access_key: nil, aws_region: 'us-east-1'
}
setting.save!
