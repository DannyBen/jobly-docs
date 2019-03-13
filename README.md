# What is Jobly

![](.gitbook/assets/terminal.gif)

![](.gitbook/assets/screen.gif)

## Installation

```text
$ gem install jobly
```

Or with the official \[Jobly docker image\]\[2\].

## What's in the Box

Jobly is a command line utility that wraps several goodies around the sidekiq backgronud jobs system. It includes the following components:

* **Command line interface** - for starting the server, starting the worker, 

  and for running jobs.

* **Web API** - for executing jobs.
* **Web Dashboard** - including job progress and status.

## Quick Start

Follow one of these annotated [examples](https://github.com/DannyBen/jobly-docs/tree/70e2af5c3e3b7e50b640f460c9e337ae16a08f41/examples/README.md).

## Usage

### Server

To start the server run `jobly server` and open [http://localhost:3000/](http://localhost:3000/) in your browser.

This will start a webserver with two primary entrypoints:

* `/` \(root\) - a dashboard for your background job processes.
* `/do/JobName?param=value` - an API for executing jobs

### Worker

To start processing jobs, run `jobly worker`

### Running jobs from the command line

There are three ways to run a job from the command line:

Run the job locally, without going through any of the background job processing chain:

```text
$ jobly run JobName param:value
```

Run the job locally, but wait for a worker to process it.

```text
$ jobly run --later JobName param:value
```

Send a job through the API \(either localhost or remote\).

```text
$ jobly send JobName param:value
```

### Running jobs through the API

The API supports running jobs either by GET or by POST in the following URL structure:

[http://localhost:3000/do/JobName](http://localhost:3000/do/JobName)

Using GET:

```text
$ curl localhost:3000/do/Build?deploy=no
# => {"status":"received","job":"Build","params":{"deploy":"no"}}
```

Using POST:

```text
$ curl -XPOST localhost:3000/do/Build -d deploy=yes
{"status":"received","job":"Build","params":{"deploy":"yes"}}
```

## Building Jobs

To build a jobs "workspace", start in an empty folder and create a `./jobs` subfolder inside it. All your job classes go in this folder \(configurable\).

All job classes will be loaded by any of Jobly's commands.

### The Job Class

A job class is a simple Ruby class inheriting from [`Jobly::Job`](https://github.com/DannyBen/jobly-docs/tree/70e2af5c3e3b7e50b640f460c9e337ae16a08f41/lib/jobly/job.rb).

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

#### Job Options

The `Jobly::Job` class supports these options:

| Key | Default | Purpose |
| :--- | :--- | :--- |
| `queue` | `default` | set the name of the queue for this job. |
| `retries` | `5` | number of times to retry on failure. |
| `backtrace` | `5` | number of backtrace lines to show in case of failures. Can be `true`, `false` or a number of lines to save. |

For example:

```ruby
class Deploy < Jobly::Job
  queue 'critical'
  backtrace 10
  retries 3

  def execute
    puts "Deploying"
  end
end
```

#### Before, After, On Failure and On Success

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

## Loading Additional Code

In case your jobs require additional functionality, you may create the `./app` folder as a sibling to the `./jobs` folder \(configurable\).

Any ruby files in this folder \(and subfolders\) will be autmatically loaded and available to your jobs.

## Configuration

Configuring Jobly can be done by one of two methods:

1. Setting environment variables.
2. Adding a `./config/jobly.rb` file.

See this [example config file](https://github.com/DannyBen/jobly-docs/tree/70e2af5c3e3b7e50b640f460c9e337ae16a08f41/examples/02-full/config/jobly.rb) for a full, annotated configuration example and a list of options with their respective environment variables.

### Worker Configuration

For advanced configuration of the sidekiq worker, beyond what the `jobly worker` command provides, you can place YAML files in the config folder and point the workers to their config file with `jobly worker --config name`.

These files are simply [sidekiq configuration files](https://github.com/mperham/sidekiq/wiki/Advanced-Options).

See the [worker-config](https://github.com/DannyBen/jobly-docs/tree/70e2af5c3e3b7e50b640f460c9e337ae16a08f41/examples/06-worker-config/README.md) example for more information.

\[2\]: [https://github.com/dannyben/docker-jobly](https://github.com/dannyben/docker-jobly)

