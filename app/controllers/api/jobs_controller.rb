class Api::JobsController < ApplicationController

  def create
    binding.pry
    jobs = IndeedApi.search_jobs(params)
    binding.pry
    render json:jobs
  end
end
