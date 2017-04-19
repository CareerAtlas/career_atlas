class Api::JobsController < ApplicationController

  def index
    jobs = IndeedApi.search_jobs(params)
    job_info = jobs["results"].map do |job|
      {
        jobtitle: job["jobtitle"],
        company: job["company"],
        url: job["url"],
        latitude: job["latitude"],
        longitude: job["longitude"],
        location: job["formattedLocationFull"],
        date_posted: job["formattedRelativeTime"]
      }
    end
    render json:job_info
  end
end
