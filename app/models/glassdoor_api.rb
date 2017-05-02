class GlassdoorApi
  include HTTParty

  def self.search_company(search_params)
    employers = get("http://api.glassdoor.com/api/api.htm?",
      {
        query:
        {
          v: 1,
          format: "json",
          "t.p": ENV["GLASSDOORID"],
          "t.k": ENV["GLASSDOORAPIKEY"],
          action: "employers",
          q: search_params["company"]
        }
      }
    )
    output_info(employers["response"]["employers"])
  end

  def self.output_info(company_info_to_output)
    company_info_to_output.map do |el|
      {
        company: el["name"],
        logo: el["squareLogo"],
        overall_rating: el["overallRating"],
        culture_rating: el["cultureAndValuesRating"],
        leadership_rating: el["seniorLeadershipRating"],
        compensation_rating: el["compensationAndBenefitsRating"],
        opportunity_rating: el["careerOpportunitiesRating"],
        work_life_balance_rating: el["workLifeBalanceRating"],
        recommend_to_friend_rating: el["recommendToFriendRating"]
      }
    end
  end
end
