Jobly.configure do |config|
  config.environment = 'production'
  config.api_url = 'http://localhost:3000/do'
  config.app_path = 'app'
  config.jobs_path = 'jobs'
  config.config_path = 'config'
  config.redis_url = 'redis://localhost:6379/0'
  config.status_expiration = 5
  config.jobs_namespace = nil
  config.log = 'jobly.log'
  # config.logger = Logger.new 'jobly.log'
end