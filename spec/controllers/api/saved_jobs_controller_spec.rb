require 'rails_helper'

RSpec.describe Api::SavedJobsController, type: :controller do

  it "will send a users jobs to be displayed" do
    john = User.create!(name: "John", email: "John@johnny.com", password: "bro", password_confirmation: "bro", authorization_token: SecureRandom.hex(10))
    job = Job.create({job_key: "24c5d6db45db2b16", longitude: -77.07143, latitude: 38.96978, company: "Precision System Design, Inc.", job_title: "Apps Developer (Android/Java)", location: "Chevy Chase, MD"})
    SavedJob.create!(user_id: john.id, job_id: job.id)
    request.headers["HTTP_AUTHORIZATION"] = john.authorization_token
    get :index
    body = JSON.parse(response.body)
    expect(body[0]["job_title"]).to eq("Apps Developer (Android/Java)")
  end

  it "will send back a selected job" do
    john = User.create!(name: "John", email: "John@johnny.com", password: "bro", password_confirmation: "bro", authorization_token: SecureRandom.hex(10))
    job = Job.create({job_key: "24c5d6db45db2b16", longitude: -77.07143, latitude: 38.96978, company: "Precision System Design, Inc.", job_title: "Apps Developer (Android/Java)", location: "Chevy Chase, MD"})
    stub_request(:get, /api.indeed.com/)
      .to_return(
        body: File.read(Rails.root.join("spec", "stubbed_requests", "single_job_search.json")),
        headers: {"Content-Type" => "application/json"}
      )
    request.headers["HTTP_AUTHORIZATION"] = john.authorization_token
    get :show, params: {job_key: job.job_key}
    body = JSON.parse(response.body)
    assert response.ok?
  end
end
