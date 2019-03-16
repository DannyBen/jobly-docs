# Logging

All your code in the `./jobs` and `./app` folders have access to a standard Ruby logger.

```ruby
class Hello < Jobly::Job
  def execute(name: 'bob')
    logger.info "said hello to #{name}"
  end
end
```

By default, output is sent to `STDOUT` but you can provide your own logger and log to a file or to syslog by using the `config.log` or the `config.logger` option in `./config/jobly.rb`

{% code-tabs %}
{% code-tabs-item title="config/jobly.rb" %}
```ruby
Jobly.configure do |config|
  config.log = '/var/log/jobly.log'
  
  # same as:
  # config.logger = Logger.new '/var/log/jobly.log'

  config.logger.level = Logger::WARN
end
```
{% endcode-tabs-item %}
{% endcode-tabs %}

The `config.log` option controls how logging is handled.

1. If left empty \(`nil`\), the web server and workers will NOT log anywhere, and your jobs will log to `STDOUT` whenever you use `logger`.
2. Setting it to `config.log = 'stdout'` will also instruct the web server and worker to send their logging to `STDOUT`.
3. Setting it to a filename, will log to a file.
4. Setting it to a syslog connection string will log to a remote syslog server. 

### Logging to Syslog

Set `config.log` to a syslog connection string in the following format:

`syslog://system:program@host:port`

Omitting any of the options will fall back to a sensible default.

{% page-ref page="../examples/syslog.md" %}

### Bring Your Own Logger

If you wish to use a custom logger, use the `config.logger` option instead of the 

`config.log` shortcut option.

