---
description: Configure the worker.
---

# Worker Configuration

The worker options can be configured by command line options or by specifying a worker configuration file when running it.

The configuration file can be used to:

* Specify default values for the worker \(instead of specifying them inside the jobs themselves\).
* Specify additional advanced sidekiq configuration options.

{% hint style="info" %}
Tip: The worker configuration file is in fact a [sidekiq configuration file](https://github.com/mperham/sidekiq/wiki/Advanced-Options). Refer to the sidekiq documentation if you need more advanced options.
{% endhint %}

### Sample Configuration File

{% code-tabs %}
{% code-tabs-item title="config/my-worker.yml" %}
```yaml
---
:concurrency: 2
:queues:
- critical
- default
- mundane

```
{% endcode-tabs-item %}
{% endcode-tabs %}

Place your YAML config file inside the config folder, and use the `jobly worker --config my-worker` to use it.

{% hint style="warning" %}
Note: The filename specified with the `--config` flag must be placed inside the config folder. You do not need to specify the folder or the `.yml` extension.
{% endhint %}

### Related Topics

{% page-ref page="../examples/worker-config.md" %}



