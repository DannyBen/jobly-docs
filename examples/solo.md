# Solo Job Example

{% file src="../.gitbook/assets/examples.zip" caption="Download Examples Folder" %}

{% hint style="info" %}
[View Example Code on GitHub](https://github.com/DannyBen/jobly-docs/tree/master/examples/files/solo)
{% endhint %}

This example demonstrates how to ensure only one instance of the job is executed at any given time.

## Code

## Commands to Try

Before running these commands, it is recommended you open the Statuses tab in the web dashboard.

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

