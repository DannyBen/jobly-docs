require_relative '../app/my_server'

Jobly.configure do |config|
  config.mounts = { "/my" => MyServer }
end