# Slack Notifications

{% file src="../.gitbook/assets/examples.zip" caption="Download Examples Folder" %}

{% hint style="info" %}
[View Example Code on GitHub](https://github.com/DannyBen/jobly-docs/tree/master/examples/files/slack-notifications)
{% endhint %}

This example illustrates how to send slack notifications from your jobs.

## Code

{% code-tabs %}
{% code-tabs-item title="app/job.rb" %}
```ruby
require 'slack-notifier'

class Job < Jobly::Job
  def slack
    @slack ||= slack!
  end

  def slack!
    Slack::Notifier.new webhook, channel: "#general", username: "Bot"
  end

  def webhook
    ENV['SLACK_WEBHOOK']
  end
end
```
{% endcode-tabs-item %}

{% code-tabs-item title="jobs/hello.rb" %}
```ruby
class Greet < Job
  def execute(name: 'bob')
    # Quick message
    slack.ping "Hello #{name}"

    # Message with attachment
    slack.post attachments: { text: "Good text", color: "good" }
  end
end
```
{% endcode-tabs-item %}
{% endcode-tabs %}


## Commands to Try

```bash
cd examples/files/slack-notifications

# Install additional gem dependencies
bundle install

# Set your slack webhook in an environment variable
export SLACK_WEBHOOK=https://hooks.slack.com/services/...

# Run the job
jobly run Greet
```

