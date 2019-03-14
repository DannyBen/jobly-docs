# Syslog

{% file src="../.gitbook/assets/examples.zip" caption="Download Examples Folder" %}

{% hint style="info" %}
[View Example Code on GitHub](https://github.com/DannyBen/jobly-docs/tree/master/examples/files/syslog)
{% endhint %}

This example illustrates how to configure Jobly to send all logger events to a local or remote syslog.

## Code

{% code-tabs %}
{% code-tabs-item title="config/jobly.rb" %}
```ruby
require 'remote_syslog_logger'

Jobly.configure do |config|

  # Configure syslog parameters
  syslog_host = ENV['SYSLOG_HOST'] || "127.0.0.1"
  syslog_port = ENV['SYSLOG_PORT'] || '514'
  sysname, program = 'my-host', 'my-app'

  # Set the Jobly logger to syslog
  config.logger = RemoteSyslogLogger.new syslog_host, syslog_port, 
    local_hostname: sysname, program: program

  config.logger.level = Logger::INFO

end
```
{% endcode-tabs-item %}

{% code-tabs-item title="jobs/hello.rb" %}
```ruby
class Hello < Jobly::Job
  def execute(name: 'bob')
    puts "Hello #{name}"
    logger.info "said hello to #{name}"
  end
end
```
{% endcode-tabs-item %}
{% endcode-tabs %}

## Commands to Try

```bash
cd examples/files/syslog

# Install additional gem dependencies
bundle install

# Start watching the syslog
sudo tail -f /var/log/syslog

# Start both the server and the worker
foreman start

# Send jobs from the command line to the API
jobly send Hello
```

