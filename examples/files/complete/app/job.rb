require "slack-notifier"

class Job < Jobly::Job
  # Common job configuration
  retries 1
  backtrace 10

  # Common job functionality, like sending slack messages
  # For this to work you need to set your slack webhook in the environment
  # variable SLACK_WEBHOOK
  def slack(message, channel: '#debug', user: 'Jobly')
    notifier = Slack::Notifier.new webhook, channel: channel, username: user
    notifier.ping message
  end

protected

  def webhook
    ENV['SLACK_WEBHOOK']
  end

end