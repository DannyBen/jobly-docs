# Job Callbacks

The `Jobly::Job` class supports these callback methods:

| Method | Description |
| :--- | :--- |
| `before` | Executes before the job starts |
| `on_skip` | Executes if `skip_job` was called from the `before` block |
| `on_success` | Executes after the job finishes, and only if it succeeds |
| `on_failure` | Executes after the job finishes, and only if it fails |
| `after` | Executes after the job finishes, regardless of success or failure |

Each callback method can either be a block or a symbol that points to a local method. WHen using a block, you will have the `params` variable available, with all the parameteres sent to the job.

For example:

```ruby
class Greet < Jobly::Job
  before do
    logger.info "Starting with #{params[:message]}"
  end

  after :reboot_computer

  def execute(message: "Hello")
    puts message
  end

  def reboot_computer
    system "reboot"
  end
end
```

In order to conditionally skip a job from its `before` block, you can call `skip_job`. This will avoid running the job, and will execute the `on_skip` action and the `after` action, if present.

