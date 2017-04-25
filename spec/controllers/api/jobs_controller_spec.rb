require 'rails_helper'

RSpec.describe Api::JobsController, type: :controller do

  it "gets required params" do
    search_params = { job_title: "Ruby", location: 20011, radius: 25, job_type: "fulltime" }

    stub_request(:get, /api.indeed.com\/ads\/apisearch/)
      .to_return(
        body: File.read(Rails.root.join("spec", "stubbed_requests", "job_search.json")),
        headers: {"Content-Type" => "application/json"}
      )
    get :index, params: search_params
    assert response.ok?
  end

  it "wont save a job if your not logged in" do
    post :create
    body = JSON.parse(response.body)
    expect(body["message"]).to eq("Please log in")
  end

  it "wil create new job and save it" do
    john = User.create!({ name: "John", email: "John@johnny.com", password: "bro", password_confirmation: "bro", authorization_token: SecureRandom.hex(10) })
    request.headers["HTTP_AUTHORIZATION"]= john.authorization_token
    post :create, params: {job: {job_key: "66d032cd079cc5ab", latitude: 38.956764, longitude: -77.361435, company: "VeriSign", location: "Reston, VA", job_title: "Developer" }}
    body = JSON.parse(response.body)
    expect(body["message"]).to eq("Job saved")
  end
end
