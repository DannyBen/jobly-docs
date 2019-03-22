# Slack Notifications Example

{% file src="../.gitbook/assets/examples.zip" caption="Download Examples Folder" %}

{% hint style="info" %}
[View Example Code on GitHub](https://github.com/DannyBen/jobly-docs/tree/master/examples/files/slack-notifications)
{% endhint %}

This example illustrates how to send slack notifications from your jobs. Note that for this to work, you need to [set up a web hook in your Slack configuration](https://slack.com/apps/A0F7XDUAZ-incoming-webhooks) and then make it available to Jobly by the `slack_webhook` option or the `JOBLY_SLACK_WEBHOOK` environment variable.

## Code

{% code-tabs %}
{% code-tabs-item title="jobs/greet.rb" %}
```ruby
class Greet < Job
  # Optional settings (defaults to #general and Jobly)
  slack_channel '#debug'
  slack_user 'Greeter'

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

# Set your slack webhook in an environment variable
export JOBLY_SLACK_WEBHOOK=https://hooks.slack.com/services/...

# Run the job
jobly run Greet
```

