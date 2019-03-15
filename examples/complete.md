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

{% code-tabs %}
{% code-tabs-item title="jobs/build.rb" %}
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
{% endcode-tabs-item %}

{% code-tabs-item title="config/jobly.rb" %}
```ruby
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
```
{% endcode-tabs-item %}

{% code-tabs-item title="app/job.rb" %}
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
{% endcode-tabs-item %}
{% endcode-tabs %}

## Commands to Try

```bash
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

