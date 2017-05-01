class Api::SavedJobsController < ApplicationController
  before_action :authorize!

  def index
    render json: current_user.jobs
  end


  def create
    @saved_job = SavedJob.new_by_job_key(job_params[:key], current_user)
    if @saved_job&.save
      render json: {message: "Job Saved", status: :created}
    else
      render json: {message: "Problem with indeed sarch", status: :failed_dependency}
    end
  end

  def show
    job = IndeedApi.find_job(params[:key])
    if job
      job_to_update = Job.find_by(job_key: params[:key])
      job_to_update.update_job(job)
      render json: job
    else
      render json: {message: "Sorry, this job is no longer available", status: :not_found}
    end
  end

  def destroy
    @job_connection = current_user.saved_jobs.joins(:job).find_by("jobs.job_key": params[:key])
    if @job_connection&.destroy
      render json: {message: "Job is no longer saved", status: :ok}
    else
      render json: {message: "There is no saved job in the database", status: :not_found}
    end
  end

  private

  def job_params
    params.require(:job).permit(:key)
  end
end
