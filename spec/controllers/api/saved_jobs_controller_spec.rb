require 'rails_helper'

RSpec.describe Api::SavedJobsController, type: :controller do

  it "will require a user to be signed in to see saved jobs" do
    get :index
    body = JSON.parse(response.body)
    expect(body["message"]).to eq("Please log in")
  end

  it "will require a user to be signed in to see a specific saved job" do
    job = create_job
    get :show, params: {job_key: job.job_key}
    body = JSON.parse(response.body)
    expect(body["message"]).to eq("Please log in")
  end

  it "will send a users jobs to be displayed" do
    john = create_john
    job = create_job
    SavedJob.create!(user_id: john.id, job_id: job.id)
    request.headers["HTTP_AUTHORIZATION"] = john.authorization_token
    get :index
    body = JSON.parse(response.body)
    expect(body[0]["job_title"]).to eq("Apps Developer (Android/Java)")
  end

  it "will send a message if the job has been removed from the site" do
    john = create_john
    job = create_job
    stub_request(:get, /api.indeed.com/)
      .to_return(
        body: File.read(Rails.root.join("spec", "stubbed_requests", "no_job_back.json")),
        headers: {"Content-Type" => "application/json"}
      )
    request.headers["HTTP_AUTHORIZATION"] = john.authorization_token
    get :show, params: {job_key: job.job_key}
    body = JSON.parse(response.body)
    expect(body["message"]).to eq("Sorry, this job is no longer available")
  end

  it "will send back a selected job and update it" do
    john = create_john
    job = create_job
    stub_request(:get, /api.indeed.com/)
      .to_return(
        body: File.read(Rails.root.join("spec", "stubbed_requests", "single_job_search.json")),
        headers: {"Content-Type" => "application/json"}
      )
    request.headers["HTTP_AUTHORIZATION"] = john.authorization_token
    get :show, params: {job_key: job.job_key}
    body = JSON.parse(response.body)
    expect(body["job_title"]).to eq("Mobile Apps Developer (Android/Java)")
  end
end
