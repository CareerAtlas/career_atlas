class Api::JobsController < ApplicationController

  def index
    jobs = IndeedApi.search_jobs(params)
    render json:jobs

  end
end
