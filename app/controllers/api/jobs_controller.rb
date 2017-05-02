class Api::JobsController < ApplicationController

  def index
    jobs = IndeedApi.search_jobs(params)
    render json: SavedJob.check_for_current_user(jobs, current_user)
  end
end
