# Running jobs with the API

The API supports running jobs either by GET or by POST in the following URL structure:

```text
http://localhost:3000/do/JobName
```

{% api-method method="get" host="curl " path="localhost:3000/do/Build?deploy=no" %}
{% api-method-summary %}
/do/JobName
{% endapi-method-summary %}

{% api-method-description %}
Execute a job.
{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-path-parameters %}
{% api-method-parameter name="job" type="string" required=true %}
The class name of the job
{% endapi-method-parameter %}
{% endapi-method-path-parameters %}

{% api-method-query-parameters %}
{% api-method-parameter name="job parameters" type="object" required=false %}
Any parameter required by the job
{% endapi-method-parameter %}
{% endapi-method-query-parameters %}
{% endapi-method-request %}

{% api-method-response %}
{% api-method-response-example httpCode=200 %}
{% api-method-response-example-description %}
Job received and sent to queue.
{% endapi-method-response-example-description %}

```text
{
  "status":"received",
  "job":"Build",
  "params": {
    "deploy":"no"
  }
}
```
{% endapi-method-response-example %}

{% api-method-response-example httpCode=404 %}
{% api-method-response-example-description %}
Job cannot be found.
{% endapi-method-response-example-description %}

```text
{
  "status": "error",
  "message": "No such job",
  "job": "BuildAndRun",
  "params": {}
}
```
{% endapi-method-response-example %}
{% endapi-method-response %}
{% endapi-method-spec %}
{% endapi-method %}

{% api-method method="post" host="curl -XPOST " path="localhost:3000/do/Build -d deploy=yes" %}
{% api-method-summary %}
/do/JobName
{% endapi-method-summary %}

{% api-method-description %}
Execute a job.
{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-path-parameters %}
{% api-method-parameter name="job" type="string" required=true %}
The class name of the job
{% endapi-method-parameter %}
{% endapi-method-path-parameters %}

{% api-method-form-data-parameters %}
{% api-method-parameter name="job parameters" type="object" required=false %}
Any parameter required by the job
{% endapi-method-parameter %}
{% endapi-method-form-data-parameters %}
{% endapi-method-request %}

{% api-method-response %}
{% api-method-response-example httpCode=200 %}
{% api-method-response-example-description %}
Job received and sent to queue.
{% endapi-method-response-example-description %}

```text
{
  "status":"received",
  "job":"Build",
  "params": {
    "deploy":"no"
  }
}
```
{% endapi-method-response-example %}

{% api-method-response-example httpCode=404 %}
{% api-method-response-example-description %}
Job cannot be found.
{% endapi-method-response-example-description %}

```text
{
  "status": "error",
  "message": "No such job",
  "job": "BuildAndRun",
  "params": {}
}
```
{% endapi-method-response-example %}
{% endapi-method-response %}
{% endapi-method-spec %}
{% endapi-method %}

