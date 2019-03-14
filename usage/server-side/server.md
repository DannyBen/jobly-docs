# Dashboard and API Server

To start the web server:

1. Run `jobly server` from the command line.
2. Open [http://localhost:3000](http://localhost:3000) in your browser.

This will start a server with two primary entry points: Web Dashboard and Jobly API.

### Web Dashboard

This dashboard is available at the root of the web server. It is a sidekiq web dashboard, with additional plugins for job progress and status.

### The Jobly API Server

This is a simple web API server that allows you to execute jobs remotely by calling `/do/JobName?param=value`.

### Related Topics

{% page-ref page="../client-side/running-jobs-with-the-api.md" %}

