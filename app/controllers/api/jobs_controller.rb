class Api::JobsController < ApplicationController
  before_action :authorize!, only: [:create, :show]

  def index
    jobs = IndeedApi.search_jobs(params)
    job_info = info_for_output(jobs["results"])
    save_jobs(job_info)
    render json: job_info
  end

  def create
    new_job = Job.new(params)
    if new_job.save
      SavedJob.create(user_id: current_user.id, job_id: new_job.id)
      render json: {message: "Job Saved", status: 	:created}
    else
      render json: {message: "Job not saved", status:	:not_acceptable}
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

  def authorize!
    unless current_user
      render json: {message: "Please login", status: :unauthorized}
    end
  end
end
