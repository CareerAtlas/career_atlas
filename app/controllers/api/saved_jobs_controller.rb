class Api::SavedJobsController < ApplicationController
  before_action :authorize!, only: [:index, :show]

  def index
    jobs_to_look_up = current_user.saved_jobs
    jobs_to_send = look_up(jobs_to_look_up)
    render json: jobs_to_send
  end

  def show
    job = IndeedApi.search_for_job(params[:job_key])
    if job["results"]&.length == 1
      job_output = info_for_output(job["results"][0])
      update_job(job_output)
      render json: job_output
    else
      render json: {message: "Sorry, this job is no longer available", status: :not_found}
    end
  end

  private

  def info_for_output(job_from_indeed)
      {
        job_title: job_from_indeed["jobtitle"],
        company: job_from_indeed["company"],
        url: job_from_indeed["url"],
        latitude: job_from_indeed["latitude"],
        longitude: job_from_indeed["longitude"],
        job_key: job_from_indeed["jobkey"],
        location: job_from_indeed["formattedLocationFull"],
        date_posted: job_from_indeed["formattedRelativeTime"]
      }
  end

  def info_to_update_job(job)
    {
      job_key: job[:job_key],
      longitude: job[:longitude],
      latitude: job[:latitude],
      company: job[:company],
      job_title: job[:jobtitle],
      location: job[:formattedLocationFull]
    }
  end

  def update_job(job_info)
    update_info = info_to_update_job(job_info)
    job = Job.find_by(job_key: update_info[:job_key])
    job.update(update_info)
    job.save
  end

  def look_up(jobs)
    jobs.map do |job|
      Job.find_by_id(job["job_id"])
    end
  end
end
