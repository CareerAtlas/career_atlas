class Api::CompaniesController < ApplicationController

  def index
    company = GlassDoorApi.search_jobs(params)
    company_info = company["employers"].map do |company|
      {
        company: company["name"],
        logo: company["squareLogo"],
        overall_rating: company["overallRating"],
        culture_rating: company["cultureAndValuesRating"],
        leadership_rating: company["seniorLeadershipRating"],
        compensation_rating: company["compensationAndBenefitsRating"],
        opportunity_rating: company["careerOpportunitiesRating"],
        work_life_balance: company["workLifeBalanceRating"],
        recommend_to_friend_rating: company["recommendToFriendRating"]
      }
    end
    render json: company_info
  end

end
