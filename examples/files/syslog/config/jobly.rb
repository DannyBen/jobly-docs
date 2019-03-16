Jobly.configure do |config|
  # Log to local syslog and use the system name `jobly` and tag `demo`
  config.log = "syslog://jobly:demo@127.0.0.1:514"
  config.logger.level = Logger::INFO
end