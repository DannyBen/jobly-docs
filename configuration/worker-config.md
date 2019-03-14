# Worker Configuration

For advanced configuration of the sidekiq worker, beyond what the `jobly worker` command provides, you can place YAML files in the config folder and point the workers to their config file with `jobly worker --config name`.

These files are simply [sidekiq configuration files](https://github.com/mperham/sidekiq/wiki/Advanced-Options).

### Related Topics

{% page-ref page="../examples/worker-config.md" %}



