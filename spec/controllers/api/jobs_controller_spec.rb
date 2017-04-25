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

  it "saves a job" do
    params = {job_title: "Software Developer", job_key: "66d032cd079cc5ab", latitude: "38.956764", longitude: "-77.361435", location: "Reston, VA", company: "VeriSign"}
    post :create, params: params, json_payload: User.create!({ name: "Moose", email: "moose@gmail.com", password: "treat", password_confirmation: "treat" })
    assert response.ok?
  end
end
