# Syslog Example

This example illustrates how to configure Jobly to send all logger events to a local or remote syslog.

### Enabling syslog UDP connection

Note that for this to work, your syslog must be configured to accept UDP connections.

Edit `/etc/rsyslog.conf` and uncomment these lines:

```php
# provides UDP syslog reception
module(load="imudp")
input(type="imudp" port="514")
```

## Code

{% code-tabs %}
{% code-tabs-item title="config/jobly.rb" %}
```ruby
Jobly.configure do |config|
  # Log to local syslog and use the system name `jobly` and tag `demo`
  config.log = "syslog://jobly:demo@127.0.0.1:514"
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
cd examples/syslog

# Install additional gem dependencies
bundle install

# Start watching the syslog
sudo tail -f /var/log/syslog

# Start both the server and the worker
foreman start

# Send jobs from the command line to the API
jobly send Hello
```

