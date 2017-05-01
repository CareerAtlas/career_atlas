require 'rails_helper'


RSpec.describe Api::UsersController, type: :controller do
  let(:params) {{user: { name: "John", email: "John@johnny.com", password: "bro", password_confirmation: "bro" }}}

  it "creates a user" do
    post :create, params: params
    assert response.ok?
    expect(User.find_by(email: "John@johnny.com")).to be_present
  end

  it "gives the user an authorization_token" do
    post :create, params: params
    john = User.find_by(email: "John@johnny.com")
    expect(john.authorization_token).to be_present
  end

  it "will not create a user without required information" do
    post :create, params: {user: { name: "John"}}
    expect(json_body["message"]).to eq("Please enter correct information")
  end

  it "destroys a user" do
    post :create, params: params
    assert response.ok?
    john = User.find_by(email: "John@johnny.com")
    request.headers["HTTP_AUTHORIZATION"] = john.authorization_token
    delete :destroy, params: {id: john.id, Authorization: john.authorization_token}
    expect(json_body["message"]).to eq("Account Deleted")
  end

  it "will not destroy an account unless they are logged in" do
    delete :destroy, params: {id: 1}
    expect(json_body["message"]).to eq("Please log in")
  end

  it "sends an email" do
    ActiveJob::Base.queue_adapter = :test
    expect{post :create, params: params}.to change{ActionMailer::Base.deliveries.count}.by(1)
  end
end
