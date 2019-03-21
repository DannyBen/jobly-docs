class Build < Job
  def execute(app: 'server', deploy: true)
    # Define how many steps this job has, for the progress bar in the 
    # Statuses tab
    total 3

    # Specify that we are at step 0, with a message for the progress bar.
    at 0, "Building"
    slack "Building `#{app}`"

    # Simulate a long running command with output to the logger.
    run 'ls -la ; sleep 10'
    
    # Simulate some more long running commands
    if deploy
      at 1, "Deploying"
      slack "Deploying `#{app}`"
      sleep 10
    end

    at 2, "Verifying"
    sleep 10

    at 3, "Completed"
    slack "Completed `#{app}`"
  end
end
