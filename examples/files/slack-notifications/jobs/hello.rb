class Greet < Job
  # Optional settings (defaults to #debug and Jobly)
  slack_channel '#debug'
  slack_user 'Greeter'

  def execute(name: 'bob')
    # Quick message
    slack.ping "Hello #{name}"

    # Message with attachment
    slack.post attachments: { text: "Good text", color: "good" }
  end
end
