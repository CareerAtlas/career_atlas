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

  def info_to_create_job(job)
    {
      job_key: job["jobkey"],
      longitude: job["longitude"],
      latitude: job["latitude"],
      company: job["company"],
      job_title: job["jobtitle"],
      location: job["location"]
    }
  end

  def create_new_job_and_save(params)
    job = IndeedApi.search_for_job(job_key)
    job_to_save = info_to_create_job(job)
    new_job = Job.new(job_to_save)
    if new_job.save
      SavedJob.create(job_id: new_job.id)
      json render: {message: "Job Saved", status: :created}
    else
      render json: {message: "Problem with indeed sarch", status:	:failed_dependency}
    end
  end

  def update_job_and_save(search_params)
    job = Job.find_by(job_key: search_params[:job_key])
    job.update(params)
    job.save
    SavedJob.create(job_id: job.id, user_id: current_user.id)
  end

end
