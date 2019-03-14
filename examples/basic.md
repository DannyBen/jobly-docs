# Basic Example

{% file src="../.gitbook/assets/examples.zip" caption="Download Examples Folder" %}

## Code

```ruby
# jobs/hello.rb
class Hello < Jobly::Job
  def execute(name: 'bob')
    puts "Hello #{name}"
    logger.info "said hello to #{name}"
  end
end
```

## Commands to Try

```text
cd examples/files/basic

# Run the job locally and immediately
jobly run Hello

# Start the worker
jobly worker

# From another terminal, send the job to the owrker
jobly run --later Hello name:Jimmy

# Start the API / Dashboard server then visit http://localhost:3000
jobly server

# From another terminal, send the job from the command line to the API
jobly send Hello

# Schedule a job by accessing the API:
open http://localhost:3000/do/Hello?name=Guest
```

