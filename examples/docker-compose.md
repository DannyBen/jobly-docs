# Docker Compose Example

{% file src="../.gitbook/assets/examples.zip" caption="Download Examples Folder" %}

{% hint style="info" %}
[View Example Code on GitHub](https://github.com/DannyBen/jobly-docs/tree/master/examples/files/docker-compose)
{% endhint %}

This example demonstrates how to use Jobly inside a docker container and with docker compose.

## Code

{% code-tabs %}
{% code-tabs-item title="Dockerfile" %}
```text
FROM dannyben/alpine-ruby
RUN gem install jobly
WORKDIR /app
COPY app .
```
{% endcode-tabs-item %}

{% code-tabs-item title="docker-compose.yml" %}
```yaml
version: '3'

services:
  redis:
    image: redis

  bash: &default
    build: .
    image: temp/jobly
    depends_on: [redis]
    volumes:
    - ./app:/app
    environment:
      JOBLY_REDIS_URL: redis://redis:6379/0
      JOBLY_API_URL: http://web:3000/do

  web:
    <<: *default
    ports: ["3000:3000"]
    command: jobly server

  worker:
    <<: *default
    command: jobly worker

  send:
    <<: *default
    depends_on: [web]
    entrypoint: jobly send
    command: Hello
```
{% endcode-tabs-item %}
{% endcode-tabs %}

## Commands to Try

```bash
cd examples/files/docker-compose

# Build the images
docker-compose build

# Start the server and the worker
docker-compose up web worker

# Visit your server
open http://localhost:3000

# Send a test job
docker-compose run send

# ... or with parameters
docker-compose run send Hello name:Bobby
```

