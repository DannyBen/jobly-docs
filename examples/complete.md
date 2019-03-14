# Complete Example

{% file src="../.gitbook/assets/examples.zip" caption="Download Examples Folder" %}

{% hint style="info" %}
[View Example Code on GitHub](https://github.com/DannyBen/jobly-docs/tree/master/examples/files/complete)
{% endhint %}

This example illustrates these aspects of Jobly:

1. How to use foreman to start both the server and the worker together in development environment - see the Procfile.
2. How to configure Jobly - see the config folder.
3. How to add additional code that is preloaded - see the app folder.
4. How to create your own Job parent class to provide common functionality to your jobs.
5. How to execute shell commands from a Job and send the output directly to the logger.
6. How to send all output to a file log instead of STDOUT.

## Code

### jobs/build.rb

```ruby
class Build < Job
  def execute(app: 'server', deploy: 'yes')
    # Define how many steps this job has, for the progress bar in the 
    # Statuses tab
    total 3

    # Specify that we are at step 0, with a message for the progress bar.
    at 0, "Building"

    # Simulate a long running command with output to the logger.
    shell.run 'ls -la ; sleep 10'

    # Simulate some more long running commands
    if deploy == 'yes'
      at 1, "Deploying"
      sleep 10
    end

    at 2, "Verifying"
    sleep 10

    at 3, "Deployed"
  end
end
```

### config/jobly.rb

```ruby
Jobly.configure do |config|
  # Full configuration file. Everything is optional and has defaults.
  # This file is loaded on boot of the server, worker and jobly CLI.
  # ---

  # environment: development | production
  # Sets the environment for the API Sinatra server and for Sidekiq.
  # Default: ENV['JOBLY_ENVIRONMENT'] || 'development'
  config.environment = 'production'

  # api_url: url
  # Sets the URL to the API server.
  # Default: ENV['JOBLY_API_URL'] || 'http://localhost:3000/do'
  config.api_url = 'http://localhost:3000/do'

  # app_path: relative or absolute path
  # Sets the path to the optional folder that may contain support files for
  # the jobs. All ruby files in this folder are loaded first.
  # Default: ENV['JOBLY_APP_PATH'] || 'app'
  config.app_path = 'app'

  # jobs_path: relative or absolute path
  # Sets the path to the jobs folder. All ruby files in this folder are loaded
  # automatically by all of Jobly's components.
  # Default: ENV['JOBLY_JOBS_PATH'] || 'jobs'
  config.jobs_path = 'jobs'

  # config_path: relative or absolute path
  # Sets the path to the config directory. This is where Jobly looks for this
  # jobly.rb configuration file, so it should be set via the environment
  # variable if you wish to change it.
  # Default: ENV['JOBLY_CONFIG_PATH'] || 'config'
  config.config_path = 'config'

  # redis_url: url
  # Sets the full URL to the redis database
  # Default: ENV['JOBLY_REDIS_URL'] || 'redis://localhost:6379/0'
  config.redis_url = 'redis://localhost:6379/0'

  # status_expiration: minutes
  # Sets the number of minutes that completed jobs are kept in the Statuses
  # tab.
  # Default: ENV['JOBLY_STATUS_EXPIRATION'] || 30
  config.status_expiration = 5

  # jobs_namespace: string
  # Sets the namespace (module name) that your jobs are defined in. For 
  # example, if your Job classes are in fact defined as `MyJobs::SomeJob` 
  # then this option should be set to `MyJobs`.
  # Default: ENV['JOBLY_JOBS_NAMESPACE'] || nil
  config.jobs_namespace = nil

  # logger: logger instance
  # Sets the logger that will be used by the servers and worker. This logger
  # is also available to your jobs with the `logger` method.
  # Default: nil (output to STDOUT)
  config.logger = Logger.new 'jobly.log'

end
```

### app/job.rb

```ruby
require 'tty-command'

class Job < Jobly::Job
  # Provide a common way for the inheriting jobs to run shell commands
  # and send output to the common logger.
  def shell
    @shell ||= TTY::Command.new(output: logger, color: false)
  end
end
```

## Commands to Try

```text
cd examples/files/complete

# Install additional gem dependencies
bundle install

# Start both the server and the worker
foreman start

# Visit the server
open http://localhost:3000

# From another terminal, send jobs from the command line to the API
jobly send Build deploy:yes
jobly send Build deploy:no

# Or send a job via curl
curl localhost:3000/do/Build?deploy=no

# View the log
cat jobly.log
```

