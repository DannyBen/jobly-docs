class Test < Jobly::Job
  def execute
    logger.info "Job Running"
  end
end
