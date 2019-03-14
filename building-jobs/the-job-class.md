# The Job Class

A job class is a simple Ruby class inheriting from `Jobly::Job`.

The only requirement is that your class implements an `execute` method that optionally accepts keyword arguments \(recommended\), or a hash.

Example:

```ruby
class Hello < Jobly::Job
  def execute(name: 'bob')
    puts "Hello #{name}"
    logger.info "said hello to #{name}"
  end
end
```

Note that these classes are simply Jobly-flavored sidekiq jobs, with these key differences:

* You need to implement `execute` instead of `perform`
* Job arguments are defined as keyword arguments, instead of positional 

  arguments.

