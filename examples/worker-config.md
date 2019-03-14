# Worker Config

{% file src="../.gitbook/assets/examples.zip" caption="Download Examples Folder" %}

{% hint style="info" %}
[View Example Code on GitHub](https://github.com/DannyBen/jobly-docs/tree/master/examples/files/worker-config)
{% endhint %}

This example makes use of worker configuration file in order to tell the worker to process two queues \(`critical` and `mundane`\) instead of the `default` queue.

Note that the same can also be achieved through the command line, without using a config file.

## Code

### config/worker.yml

```yaml
:concurrency: 2
:queues:
- critical
- default
- mundane
```

### jobs/critical.rb

```ruby
class Critical < Jobly::Job
  options queue: 'critical'

  def execute
    logger.info "Running a critical job"
  end
end
```

### jobs/mundane.rb

```ruby
class Mundane < Jobly::Job
  options queue: 'mundane'

  def execute
    logger.info "Running a mundane job"
  end
end
```

### Procfile

```text
web: jobly server
worker: jobly worker --config worker
```

## Commands to Try

```text
cd examples/files/worker-config

# Start the server and worker
# Note that the `Procfile` is defined to run `jobly worker --config worker`
# which points the worker to the `config/worker.yml` configuration file
foreman start

# From another terminal, send the jobs to the owrker
jobly send Critical
jobly send Mundane
```

