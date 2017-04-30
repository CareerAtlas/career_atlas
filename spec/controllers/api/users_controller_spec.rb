require 'rails_helper'


RSpec.describe Api::UsersController, type: :controller do

  it "creates a user" do
    params = {user: { name: "John", email: "John@johnny.com", password: "bro", password_confirmation: "bro" }}
    post :create, params: params
    assert response.ok?
    expect(User.find_by(email: "John@johnny.com")).to be_present
  end

  it "gives the user an authorization_token" do
    params = {user: { name: "John", email: "John@johnny.com", password: "bro", password_confirmation: "bro" }}
    post :create, params: params
    john = User.find_by(email: "John@johnny.com")
    expect(john.authorization_token).to be_present
  end

  it "will not create a user without required information" do
    params = {user: { name: "John", password: "bro", password_confirmation: "bro" }}
    post :create, params: params
    body = JSON.parse(response.body)
    expect(body["message"]).to eq("Please enter correct information")
  end

  it "destroys a user" do
    params = {user: { name: "John", email: "John@johnny.com", password: "bro", password_confirmation: "bro" }}
    post :create, params: params
    assert response.ok?
    john = User.find_by(email: "John@johnny.com")
    request.headers["HTTP_AUTHORIZATION"] = john.authorization_token
    delete :destroy, params: {id: john.id, Authorization: john.authorization_token}
    body = JSON.parse(response.body)
    expect(body["message"]).to eq("Account Deleted")
  end

  it "will not destroy an account unless they are logged in" do
    delete :destroy, params: {id: 1}
    body = JSON.parse(response.body)
    expect(body["message"]).to eq("Please log in")
  end
end
