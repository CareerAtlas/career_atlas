require 'rails_helper'

RSpec.describe Api::JobsController, type: :controller do

  let(:john) { create_john }
  let(:search_params) {{ job_title: "Ruby", location: 20011, radius: 25, job_type: "fulltime" }}

  it "gets a list of jobs back" do
    stub_request(:get, /api.indeed.com\/ads\/apisearch/)
      .to_return(
        body: File.read(Rails.root.join("spec", "stubbed_requests", "job_search.json")),
        headers: {"Content-Type" => "application/json"}
      )
    get :index, params: search_params
    expect(json_body[0]["company"]).to eq("VeriSign")
    expect(json_body.count).to be > 1
  end

  it "makes all saved keys on jobs false if no one is logged in" do
    stub_request(:get, /api.indeed.com\/ads\/apisearch/)
      .to_return(
        body: File.read(Rails.root.join("spec", "stubbed_requests", "job_search.json")),
        headers: {"Content-Type" => "application/json"}
      )
    get :index, params: search_params
    expect(json_body[0]["saved"]).to eq(false)
  end

  it "makes all saved keys on jobs false if the user doesn't have the job saved" do
    stub_request(:get, /api.indeed.com\/ads\/apisearch/)
      .to_return(
        body: File.read(Rails.root.join("spec", "stubbed_requests", "job_search.json")),
        headers: {"Content-Type" => "application/json"}
      )
    request.headers["HTTP_AUTHORIZATION"] = john.authorization_token
    get :index, params: search_params
    expect(json_body[0]["saved"]).to eq(false)
  end

  it "maked the saved keys on jobs true if the user has saved that job key" do
    job = Job.create!(
      job_key: "66d032cd079cc5ab",
      longitude: -77.361435,
      latitude: 38.956764,
      company: "VeriSign",
      job_title: "Software Engineering - University graduates",
      location: "Reston, VA",
      url: "www.Indeed.com"
      )
      SavedJob.create!(user: john, job: job)
    stub_request(:get, /api.indeed.com\/ads\/apisearch/)
      .to_return(
        body: File.read(Rails.root.join("spec", "stubbed_requests", "job_search.json")),
        headers: {"Content-Type" => "application/json"}
      )
    request.headers["HTTP_AUTHORIZATION"] = john.authorization_token
    get :index, params: search_params
    expect(json_body[0]["saved"]).to eq(true)
  end
end
