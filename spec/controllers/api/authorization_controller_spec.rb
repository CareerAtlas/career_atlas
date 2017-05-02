require 'rails_helper'

RSpec.describe Api::AuthorizationController, type: :controller do
  let(:john) { create_john }

  it "allows someone to log in" do
    post :create, params: { user: {email: john.email, password: "bro"} }
    expect(json_body["authorization"]).to be_present
  end

  it "wont allow someone to log in if they have not created an account" do
    post :create, params: {user: {email: "John@johnny.com", password: "bro"}}
    expect(json_body["message"]).to eq("Email or Password in not correct")
  end

  it "wont allow someone to logi n they have the wrong email" do
    post :create, params: {user: {email: "J@johnny.com", password: "bro"}}
    expect(json_body["message"]).to eq("Email or Password in not correct")
  end

  it "wont allow someone to log in if they have the wrong password" do
    post :create, params: {user: {email: "John@johnny.com", password: "dude"}}
    expect(json_body["message"]).to eq("Email or Password in not correct")
  end

  it "wont allow someone to logout if they have not logged in first" do
    delete :destroy
    expect(json_body["message"]).to eq("Please log in first")
  end

  it "will allow someone to logout if they have logged in" do
    post :create, params: { user: {email: john.email, password: "bro"} }
    assert response.ok?
    request.headers["HTTP_AUTHORIZATION"] = john.authorization_token
    delete :destroy
    expect(json_body["message"]).to eq("You are now logged out")
  end

  it "wont allow someone to to log out with the wrong auth token" do
    post :create, params: { user: {email: john.email, password: "bro"} }
    assert response.ok?
    request.headers["HTTP_AUTHORIZATION"] = "hello"
    delete :destroy
    expect(json_body["message"]).to eq("Please log in first")  end
end
