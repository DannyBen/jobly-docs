# Basic Auth Example

## Commands to Try

```bash
cd examples/basic

# Start the server with basic auth enabled
JOBLY_AUTH=user:pass jobly server

# Send a job without authentication
# This operation will fail
jobly send Hello

# Send an authenticated job request
# This operation will succeed
JOBLY_AUTH=user:pass jobly send Hello
```

