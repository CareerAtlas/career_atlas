class Api::CompaniesController < ApplicationController

  def index
    company = GlassDoorApi.search_jobs(params)
    company_info = company["employers"].map do |company|
      {
        company: company["name"],
        logo: company["squareLogo"],
        overall_rating: company["overallRating"],

      }
    end
    render json: company_info
  end

end
