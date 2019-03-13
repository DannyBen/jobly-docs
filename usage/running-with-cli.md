# Running jobs from the command line

There are three ways to run a job from the command line:

Run the job locally, without going through any of the background job 
processing chain:

    $ jobly run JobName param:value


Run the job locally, but wait for a worker to process it.

    $ jobly run --later JobName param:value


Send a job through the API (either localhost or remote).

    $ jobly send JobName param:value

