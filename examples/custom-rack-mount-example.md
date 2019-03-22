# Custom Rack Mount

{% file src="../.gitbook/assets/examples.zip" caption="Download Examples Folder" %}

{% hint style="info" %}
[View Example Code on GitHub](https://github.com/DannyBen/jobly-docs/tree/master/examples/files/custom-rack-mount)
{% endhint %}

This example demonstrates how to ammend the web server so that it also serves any custom rack app.

## Code

{% code-tabs %}
{% code-tabs-item title="config/jobly.rb" %}
```ruby
require_relative '../app/my_server'

Jobly.configure do |config|
  config.mounts = { "/my" => MyServer }
end
```
{% endcode-tabs-item %}

{% code-tabs-item title="app/my\_Server.rb" %}
```ruby
require "sinatra/base"

class MyServer < Sinatra::Base
  get '/' do
    "Hello from MyServer!"
  end
end
```
{% endcode-tabs-item %}
{% endcode-tabs %}

## Commands to Try

```bash
cd examples/custom-rack-mount

# Start the server
jobly server

# Call your custom app
curl http://localhost:3000/my
```

