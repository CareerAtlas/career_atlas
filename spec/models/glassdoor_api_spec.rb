require 'rails_helper'

RSpec.describe GlassdoorApi, type: :model do

  it "receives response when asking Glassdoor about a company" do
    stub_request(:get, "http://api.glassdoor.com/api/api.htm")
      .to_return(
        body: File.read(Rails.root.join("spec", "stubbed_requests", "company_search.json")),
        headers: {'Content-Type' => 'application/json'}
      )
      answer = GlassdoorApi.search_company("127.0.0.1", "Chrome", "Verisign")
      expect(answer["response"]["employers"][0]["website"]).to eq "www.verisign.com"
  end

end
