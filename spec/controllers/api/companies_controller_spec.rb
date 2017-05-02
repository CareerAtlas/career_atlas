require 'rails_helper'

RSpec.describe Api::CompaniesController, type: :controller do
  it "gets requested companies information" do
    search_params = { company: "Verisign"}

    stub_request(:get, /api.glassdoor.com/)
    .to_return(
      body: File.read(Rails.root.join("spec", "stubbed_requests", "company_search.json")),
      headers: {'Content-Type' => 'application/json'}
    )

    get :index, params: search_params
    expect(json_body[0]["company"]).to eq("Verisign")
    expect(json_body[0]["compensation_rating"]).to eq("4.3")
  end
end
