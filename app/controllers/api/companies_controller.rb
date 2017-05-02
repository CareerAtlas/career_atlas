class Api::CompaniesController < ApplicationController

  def index
    company = GlassdoorApi.search_company(params)
    render json: company
  end

  private


end
