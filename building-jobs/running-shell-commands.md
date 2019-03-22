# Running Shell Commands

Although you can use any Ruby method to execute shell and system commands from within your jobs, Jobly comes bundled with [TTY::Command](https://github.com/piotrmurach/tty-command) which is made available to your jobs by using the `#shell` method.

{% code-tabs %}
{% code-tabs-item title="jobs/shell.rb" %}
```ruby
class Shell < Jobly::Job
  def execute
    shell.run "docker pull ubuntu"
  end
end
```
{% endcode-tabs-item %}
{% endcode-tabs %}

Using this method automatically sends the STDOUT and STDERR of the command to the configured logging device.

