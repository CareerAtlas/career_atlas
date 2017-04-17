require 'rails_helper'

RSpec.describe IndeedApi, type: :model do

  it "receives response when asking indeed for jobs" do
    stub_request(:get, "http://api.indeed.com/ads/apisearch")
      .to_return(
        body: File.read(Rails.root.join("spec", "stubbed_requests", "job_search.json")),
        headers: {'Content-Type' => 'application/json'}
      )
    response = IndeedApi.search_jobs "ruby", "20180", "fulltime", "127.0.0.1", "Chrome"
    expect(response).to be_truthy
    expect(response["results"][0]["jobtitle"]).to eq "Software Engineering - University graduates"
  end
end
