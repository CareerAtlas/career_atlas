class Api::JobsController < ApplicationController
  before_action :authorize!, only: [:create, :show]

  def index
    jobs = IndeedApi.search_jobs(params)
    job_info = info_for_output(jobs["results"])
    render json: job_info
  end

  def create
    unless Job.find_by(job_key: job_params[:jobkeys])
      create_new_job_and_save(job_params[:jobkeys])
    else
      update_job_and_save(job_params[:jobkeys])
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
        job_key: job["jobkey"],
        location: job["formattedLocationFull"],
        date_posted: job["formattedRelativeTime"]
      }
    end
  end

  def job_params
    params.require(:job).permit(:jobkeys)
  end

  def info_to_create_job(job)
    {
      job_key: job["jobkey"],
      longitude: job["longitude"],
      latitude: job["latitude"],
      company: job["company"],
      job_title: job["jobtitle"],
      location: job["formattedLocationFull"]
    }
  end

  def create_new_job_and_save(job_key)
    job = IndeedApi.search_for_job(job_key)
    job_to_save = info_to_create_job(job["results"][0])
    new_job = Job.new(job_to_save)
    if new_job.save
      SavedJob.create(job_id: new_job.id, user_id: current_user.id)
      render json: {message: "Job Saved", status: :created}
    else
      render json: {message: "Problem with indeed sarch", status:	:failed_dependency}
    end
  end

  def update_job_and_save(job_key)
    job = Job.find_by(job_key: job_key)
    job_from_indeed = IndeedApi.search_for_job(job_key)
    job_update = info_to_create_job(job_from_indeed["results"][0])
    job.update(job_update)
    job.save
    SavedJob.create(job_id: job.id, user_id: current_user.id)
  end

end
