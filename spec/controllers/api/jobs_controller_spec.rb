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
    body = JSON.parse(response.body)
    expect(body[0]["company"]).to eq("VeriSign")
  end

  it "wont save a job if your not logged in" do
    post :create
    body = JSON.parse(response.body)
    expect(body["message"]).to eq("Please log in")
  end

  it "will create new job and save it if you are logged in" do
    john = create_john
    job_key = { job: {jobkeys: "24c5d6db45db2b16" }}
    stub_request(:get, /api.indeed.com/)
      .to_return(
        body: File.read(Rails.root.join("spec", "stubbed_requests", "single_job_search.json")),
        headers: {"Content-Type" => "application/json"}
      )
      request.headers["HTTP_AUTHORIZATION"] = john.authorization_token
      post :create, params: job_key
      body = JSON.parse(response.body)
      expect(body["message"]).to eq("Job Saved")
      expect(Job.find_by(job_key: "24c5d6db45db2b16")).to be_present
  end

  it "wont save a job if its missing core information" do
    john = create_john
    job_key = { job: {jobkeys: "24c5d6db45db2b16" }}
    stub_request(:get, /api.indeed.com/)
      .to_return(
        body: File.read(Rails.root.join("spec", "stubbed_requests", "incomplete_single_job_search.json")),
        headers: {"Content-Type" => "application/json"}
      )
      request.headers["HTTP_AUTHORIZATION"] = john.authorization_token
      post :create, params: job_key
      body = JSON.parse(response.body)
      expect(body["message"]).to eq("Problem with indeed sarch")
  end

  it "will update job with new information" do
    john = create_john
    create_job
    stub_request(:get, /api.indeed.com/)
      .to_return(
        body: File.read(Rails.root.join("spec", "stubbed_requests", "single_job_search.json")),
        headers: {"Content-Type" => "application/json"}
      )
    request.headers["HTTP_AUTHORIZATION"] = john.authorization_token
    post :create, params: {job: {jobkeys: "24c5d6db45db2b16"}}
    body = JSON.parse(response.body)
    expect(body["message"]).to eq("Job Saved")
    job = Job.find_by(job_key: "24c5d6db45db2b16")
    expect(job.job_title).to eq("Mobile Apps Developer (Android/Java)")
  end

end
