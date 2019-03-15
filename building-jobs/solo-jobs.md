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

Solo Jobs (also known as Unique Jobs) will register a lock key in redis before execution which will prevent subsequent jobs with the same fingerpring from running until the lock is deleted. The lock will be automatically removed when the job complets (even if it fails), or after a one hour expiration period.


## Job Fingerprint

By default, the job's fingerprint is built of its class name and its paramters. You can specify a different fingerprint in one of two ways:

### Option 1: Use the `key` property:

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

## Lock Expiration Safeguard

By default, the locks are set to expire after one hour. This is designed as a safeguard to avoid dead locks. Under most circumstances, you do not need to worry about it, since locks are automatically removed on job completion, but in case you wish to change the default expiration period, you can use the `expire` option when calling `solo`:

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

You can use `seconds`, `minutes`, `hours` and `days.

