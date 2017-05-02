require "rails_helper"

RSpec.describe WalkscoreApi, type: :model do

  it "receives response when asking walk score for scores" do
    params = {
      wsapikey: "5108b6df6ffbdbd8ad43d4a5dc25ee8a",
      lat: 40.751652,
      lon: -73.975311,
      address: "405 Lexington Ave, New York City 10174",
      transit: 1,
      bike: 1,
      format: "json"
    }
    stub_request(:get, /api.walkscore.com/)
      .to_return(
        body: File.read(Rails.root.join("spec", "stubbed_requests", "walkscore_search.json")),
        headers: {"Content-Type" => "application/json"}
      )
      answer = WalkscoreApi.search_walkscore(params)
      expect(answer[:walk_score]).to eq 100

  end
end
