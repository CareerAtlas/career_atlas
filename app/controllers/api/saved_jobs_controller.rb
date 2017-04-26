class Api::SavedJobsController < ApplicationController
  before_action :authorize!, only: [:create, :show]
  
  def index
    #code
  end

  def show
    #code
  end

  private

  def authorize!
    unless current_user
      render json: {message: "Please log in", status: :unauthorized}
    end
  end
end
