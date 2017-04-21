require 'rails_helper'

RSpec.describe Api::WalkscoresController, type: :controller do

  it "gets required params" do
    search_params = {
      lat: 40.751652,
      lon: -73.975311,
      address: "405 Lexington Ave, New York City 10174"
    }
    stub_request(:get, /api.walkscore.com/)
      .to_return(
        body: File.read(Rails.root.join("spec", "stubbed_requests", "walkscore_search.json")),
        headers: {"Content-Type" => "application/json"}
      )
      get :index, params: search_params
      assert response.ok?
  end

end
