class JobsController < ApplicationController

  def index
    response = Indeed.search_jobs(params)
    
  end
end
