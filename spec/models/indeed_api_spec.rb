require 'rails_helper'

RSpec.describe IndeedApi, type: :model do

  it "receives response when asking indeed for jobs" do
    search_params = { job_title: "Ruby", location: 20011, radius: 25, job_type: "fulltime" }

    stub_request(:get, /api.indeed.com\/ads\/apisearch/)
      .to_return(
        body: File.read(Rails.root.join("spec", "stubbed_requests", "job_search.json")),
        headers: {'Content-Type' => 'application/json'}
      )

    response = IndeedApi.search_jobs(search_params).first
    expect(response).to be_truthy
    expect(response[:job_title]).to eq "Software Engineering - University graduates"
  end
end
