# Running jobs with the API

The API supports running jobs either by GET or by POST in the following URL structure:

```
http://localhost:3000/do/JobName
```

Using GET:

```
$ curl localhost:3000/do/Build?deploy=no
# => {"status":"received","job":"Build","params":{"deploy":"no"}}
```

Using POST:

```
$ curl -XPOST localhost:3000/do/Build -d deploy=yes
{"status":"received","job":"Build","params":{"deploy":"yes"}}
```

