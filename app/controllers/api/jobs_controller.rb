class Api::JobsController < ApplicationController
  before_action :authorize!, only: [:create, :show]

  def index
    jobs = IndeedApi.search_jobs(params)
    job_info = info_for_output(jobs["results"])
    render json: job_info
  end

  def create
    unless Job.find_by(job_key: job_params[:job_key])
      create_new_job_and_save(job_params)
    else
      update_job_and_save(params[:job])
      render json: {message: "Job Saved", status: :created}
    end
  end

  private
  def info_for_output(jobs)
    jobs.map do |job|
      {
        jobtitle: job["jobtitle"],
        company: job["company"],
        url: job["url"],
        latitude: job["latitude"],
        longitude: job["longitude"],
        key: job["jobkey"],
        location: job["formattedLocationFull"],
        date_posted: job["formattedRelativeTime"]
      }
    end
  end

  def job_params
    params.require(:job).permit(:job_key)
  end

  def authorize!
    unless current_user
      render json: {message: "Please log in", status: :unauthorized}
    end
  end

  def create_new_job_and_save(params)
    binding.pry
    
  end

  def update_job_and_save(params)
    job = Job.find_by(job_key: params[:job_key])
    job.update(params)
    job.save
    SavedJob.create(job_id: job.id, user_id: current_user.id)
  end

end
