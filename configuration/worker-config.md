# Worker Configuration

For advanced configuration of the sidekiq worker, beyond what the `jobly worker` command provides, you can place YAML files in the config folder and point the workers to their config file with `jobly worker --config name`.

These files are simply [sidekiq configuration files](https://github.com/mperham/sidekiq/wiki/Advanced-Options).

See the [worker-config](https://github.com/DannyBen/jobly-docs/tree/3064beae6ab00055841f8b33b7631dcf0694993a/examples/06-worker-config/README.md) example for more information.

