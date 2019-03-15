# Solo Jobs

Jobs can be defined so that they only have one instance running at any given time, by using the `solo` method.

```ruby
class Test < Jobly::Job
  solo

  def execute
    # Job code here
  end
end
```

Solo Jobs \(also known as Unique Jobs\) will register a lock key in redis before execution, which will prevent subsequent jobs with the same fingerprint from running until the lock is released. The lock will be automatically removed when the job completes \(even if it fails\), or after a one hour expiration period.

When a job is skipped due to locking, it will execute the `on_skip` callback.

## Job Fingerprint

By default, the job's fingerprint is built of its class name and its parameters. You can specify a different fingerprint in one of two ways:

### Option 1 - Use the `key` property:

```ruby
class Test < Jobly::Job
  solo key: 'my-test-job'

  def execute
    # Job code here
  end
end
```

### Option 2: Define a `solo_key` method in your job:

```ruby
class Test < Jobly::Job
  solo

  def execute(region: 'eu')
    # Job code here
  end

  def solo_key
    "Test:#{param[:region]}"
  end
end
```

{% hint style="info" %}
Tip: The `solo_key` method can use any of the job's parameters by accessing the `params` hash.
{% endhint %}

## Lock Expiration Safeguard

By default, the locks are set to expire after one hour. This is designed as a safeguard to avoid dead locks. Under most circumstances, you do not need to worry about it, since locks are automatically released on job completion, but in case you wish to change the default expiration period, you can use the `expire` option:

```ruby
class Test < Jobly::Job
  solo expire: 30.minutes

  def execute(region: 'eu')
    # Job code here
  end

  def solo_key
    "Test:#{param[:region]}"
  end
end
```

You can use `seconds`, `minutes`, `hours` and `days`.

{% hint style="warning" %}
Note: Expiration timer starts to count down from the moment the job is queued, and _not_ from the moment it is executed. 
{% endhint %}


## Related Topics

- Callbacks
- Solo Example
