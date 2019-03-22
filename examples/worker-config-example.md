# Worker Config Example

{% file src="../.gitbook/assets/examples.zip" caption="Download Examples Folder" %}

{% hint style="info" %}
[View Example Code on GitHub](https://github.com/DannyBen/jobly-docs/tree/master/examples/files/worker-config)
{% endhint %}

This example makes use of worker configuration file in order to tell the worker to process two queues \(`critical` and `mundane`\) instead of the `default` queue.

Note that the same can also be achieved through the command line, without using a config file.

## Code

{% code-tabs %}
{% code-tabs-item title="config/worker.yml" %}
```yaml
:concurrency: 2
:queues:
- critical
- default
- mundane
```
{% endcode-tabs-item %}

{% code-tabs-item title="jobs/critical.rb" %}
```ruby
class Critical < Jobly::Job
  options queue: 'critical'

  def execute
    logger.info "Running a critical job"
  end
end
```
{% endcode-tabs-item %}

{% code-tabs-item title="jobs/mundane.rb" %}
```ruby
class Mundane < Jobly::Job
  options queue: 'mundane'

  def execute
    logger.info "Running a mundane job"
  end
end
```
{% endcode-tabs-item %}

{% code-tabs-item title="Procfile" %}
```text
web: jobly server
worker: jobly worker --config worker
```
{% endcode-tabs-item %}
{% endcode-tabs %}

## Commands to Try

```bash
cd examples/worker-config

# Start the server and worker
# Note that the `Procfile` is defined to run `jobly worker --config worker`
# which points the worker to the `config/worker.yml` configuration file
foreman start

# From another terminal, send the jobs to the owrker
jobly send Critical
jobly send Mundane
```

