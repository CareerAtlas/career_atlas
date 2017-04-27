class Api::JobsController < ApplicationController
  before_action :authorize!, only: [:create, :show]

  def index
    jobs = IndeedApi.search_jobs(params)
    render json: jobs
  end

  def create
    job = Job.find_by(job_key: job_params[:key])
    unless job
      create_new_job_and_save(job_params[:key])
    else
      job.update_job_and_save(job.job_key)
      SavedJob.create(job_id: job.id, user_id: current_user.id)
      render json: {message: "Job Saved", status: :created}
    end
  end

  private

  def job_params
    params.require(:job).permit(:key)
  end

  def create_new_job_and_save(job_key)
    job_data = IndeedApi.find_job(job_key).except(:url, :date_posted)
    @job = Job.new(job_data)
    if @job.save
      SavedJob.create(job_id: @job.id, user_id: current_user.id)
      render json: {message: "Job Saved", status: :created}
    else
      render json: {message: "Problem with indeed sarch", status:	:failed_dependency}
    end
  end
end
