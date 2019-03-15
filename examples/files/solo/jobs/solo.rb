class Solo < Jobly::Job
  solo

  on_skip do
    at 70, "Skipped"
    logger.info "Job was skipped"
  end

  def execute(name: 'bob')
    total 100
    at 10, "Initializing"
    sleep 20
    at 100, "Done"
  end
end
