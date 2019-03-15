# Solo Job Example

{% file src="../.gitbook/assets/examples.zip" caption="Download Examples Folder" %}

{% hint style="info" %}
[View Example Code on GitHub](https://github.com/DannyBen/jobly-docs/tree/master/examples/files/solo)
{% endhint %}

This example demonstrates how to ensure only one instance of the job is executed at any given time.

## Code

{% code-tabs %}
{% code-tabs-item title="jobs/solo.rb" %}
```ruby
class Solo < Jobly::Job
  solo

  on_skip do
    at 70, "Skipped"
    logger.info "Job was skipped"
  end

  def execute(name: 'bob')
    total 100
    at 10, "Initializing"
    sleep 20
    at 100, "Done"
  end
end
```
{% endcode-tabs-item %}


## Commands to Try

Before running these commands, it is recommended you open the Statuses tab in teh web dashboard.

```bash
cd examples/files/solo

# Start the server and worker
foreman start

# From another terminal, send the Solo job twice
jobly send Solo
jobly send Solo

# Finally, while the job is still locked, send it again with different 
# parameters (and therefore, a different fingerprint).
jobly send Solo name:Bart
```

