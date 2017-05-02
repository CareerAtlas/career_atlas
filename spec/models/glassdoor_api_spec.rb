require 'rails_helper'

RSpec.describe GlassdoorApi, type: :model do

  it "receives response when asking Glassdoor about a company" do
    params = { company: "Verisign" }
    stub_request(:get, /api.glassdoor.com/)
      .to_return(
        body: File.read(Rails.root.join("spec", "stubbed_requests", "company_search.json")),
        headers: {"Content-Type" => "application/json"}
      )
      answer = GlassdoorApi.search_company(params)
      expect(answer[0][:recommend_to_friend_rating]).to eq 64
  end

end
