# Job Options

The `Jobly::Job` class supports these class-level options:

| Key | Default | Purpose |
| :--- | :--- | :--- |
| `queue` | `default` | set the name of the queue for this job. |
| `retries` | `5` | number of times to retry on failure. |
| `backtrace` | `5` | number of backtrace lines to show in case of failures. Can be `true`, `false` or a number of lines to save. |
| `solo` | `false` | Specify that this task should only be executed once. If the same job is executed while this job is running, it will be skipped. See [Solo Jobs](solo-jobs.md) for more information. |

For example:

```ruby
class Deploy < Jobly::Job
  solo
  queue 'critical'
  backtrace 10
  retries 3

  def execute
    puts "Deploying"
  end
end
```

### Related Topics

{% page-ref page="solo-jobs.md" %}

