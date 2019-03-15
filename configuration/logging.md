# Logging

All your code in the `./jobs` and `./app` folders have access to a standard Ruby logger.

```ruby
class Hello < Jobly::Job
  def execute(name: 'bob')
    logger.info "said hello to #{name}"
  end
end
```

By default, output is sent to `STDOUT` but you can provide your own logger and log to a file or to syslog by using the `config.logger` option in `./config/jobly.rb`

{% code-tabs %}
{% code-tabs-item title="config/jobly.rb" %}
```ruby
Jobly.configure do |config|
  config.logger = Logger.new '/var/log/jobly.log'
  config.logger.level = Logger::WARN
end

```
{% endcode-tabs-item %}
{% endcode-tabs %}

{% page-ref page="../examples/syslog.md" %}

