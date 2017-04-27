class Api::SavedJobsController < ApplicationController
  before_action :authorize!, only: [:index, :show]

  def index
    render json: current_user.jobs
  end

  def show
    job = IndeedApi.find_job(params[:job_key])
    if job
      job_to_update = Job.find_by(job_key: params[:job_key])
      job_to_update.update_job(job)
      render json: job
    else
      render json: {message: "Sorry, this job is no longer available", status: :not_found}
    end
  end
end
