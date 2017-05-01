require 'rails_helper'

RSpec.describe Api::SavedJobsController, type: :controller do

  let(:john) { create_john }
  let(:job) { create_job }

  it "will require a user to be signed in to see saved jobs" do
    get :index
    expect(json_body["message"]).to eq("Please log in")
  end

  it "wont save a job if your not logged in" do
    post :create
    expect(json_body["message"]).to eq("Please log in")
  end

  it "will create new job and save it if you are logged in" do
    job_key = { job: {key: "24c5d6db45db2b16" }}
    stub_request(:get, /api.indeed.com/)
      .to_return(
        body: File.read(Rails.root.join("spec", "stubbed_requests", "single_job_search.json")),
        headers: {"Content-Type" => "application/json"}
      )
      request.headers["HTTP_AUTHORIZATION"] = john.authorization_token
      post :create, params: job_key
      expect(json_body["message"]).to eq("Job Saved")
      expect(Job.find_by(job_key: "24c5d6db45db2b16")).to be_present
  end

  it "will require a user to be signed in to see a specific saved job" do
    get :show, params: {key: "24c5d6db45db2b16" }
    expect(json_body["message"]).to eq("Please log in")
  end

  it "will send a users jobs to be displayed" do
    SavedJob.create!(user_id: john.id, job_id: job.id)
    request.headers["HTTP_AUTHORIZATION"] = john.authorization_token
    get :index
    expect(json_body[0]["job_title"]).to eq("Apps Developer (Android/Java)")
  end

  it "will send a message if the job has been removed from the site" do
    stub_request(:get, /api.indeed.com/)
      .to_return(
        body: File.read(Rails.root.join("spec", "stubbed_requests", "no_job_back.json")),
        headers: {"Content-Type" => "application/json"}
      )
    request.headers["HTTP_AUTHORIZATION"] = john.authorization_token
    get :show, params: {key: "24c5d6db45db2b16" }
    expect(json_body["message"]).to eq("Sorry, this job is no longer available")
  end

  it "will send back a selected job and update it" do
    create_job
    stub_request(:get, /api.indeed.com/)
      .to_return(
        body: File.read(Rails.root.join("spec", "stubbed_requests", "single_job_search.json")),
        headers: {"Content-Type" => "application/json"}
      )
    request.headers["HTTP_AUTHORIZATION"] = john.authorization_token
    get :show, params: {key: "24c5d6db45db2b16" }
    expect(json_body["job_title"]).to eq("Mobile Apps Developer (Android/Java)")
  end

  it "wont save a job if its missing core information" do
    job_key = { job: {key: "24c5d6db45db2b16" }}
    stub_request(:get, /api.indeed.com/)
      .to_return(
        body: File.read(Rails.root.join("spec", "stubbed_requests", "incomplete_single_job_search.json")),
        headers: {"Content-Type" => "application/json"}
      )
      request.headers["HTTP_AUTHORIZATION"] = john.authorization_token
      post :create, params: job_key
      expect(json_body["message"]).to eq("Problem with indeed sarch")
  end

  it "will update job with new information" do
    create_job
    job_key = { job: {key: "24c5d6db45db2b16" }}
    stub_request(:get, /api.indeed.com/)
      .to_return(
        body: File.read(Rails.root.join("spec", "stubbed_requests", "single_job_search.json")),
        headers: {"Content-Type" => "application/json"}
      )
    request.headers["HTTP_AUTHORIZATION"] = john.authorization_token
    post :create, params: job_key
    expect(json_body["message"]).to eq("Job Saved")
    job = Job.find_by(job_key: "24c5d6db45db2b16")
    expect(job.job_title).to eq("Mobile Apps Developer (Android/Java)")
  end

    it "will destroy a SavedJob" do
      SavedJob.create!(job_id: job.id, user_id: john.id)
      request.headers["HTTP_AUTHORIZATION"] = john.authorization_token
      delete :destroy, params: {key: job.job_key}
      expect(json_body["message"]).to eq("Job is no longer saved")
    end

    it "wont destroy a SavedJob if it doesn't have all the info" do
      request.headers["HTTP_AUTHORIZATION"] = john.authorization_token
      delete :destroy, params: {key: job.job_key}
      binding.pry
      expect(json_body["message"]).to eq("Job is no longer saved")
    end
end
