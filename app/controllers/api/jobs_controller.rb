class Api::JobsController < ApplicationController

  def index
    jobs_from_indeed = IndeedApi.search_jobs(params)
    render json: SavedJob.check_for_current_user(jobs_from_indeed, current_user)
  end
end
