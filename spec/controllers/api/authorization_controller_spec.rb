require 'rails_helper'

RSpec.describe Api::AuthorizationController, type: :controller do

  it "allows someone to log in" do
    User.create!(name: "John", email: "John@johnny.com", password: "bro", password_confirmation: "bro", authorization_token: SecureRandom.hex(10))
    john = User.find_by(email: "John@johnny.com")
    post :create, params: { user: {email: john.email, password: "bro"} }
    body = JSON.parse(response.body)
    expect(body["authorization"]).to be_present
  end

  it "wont allow someone to log in if they have not created an account" do
    post :create, params: {user: {email: "John@johnny.com", password: "bro"}}
    body = JSON.parse(response.body)
    expect(body["message"]).to eq("Email or Password in not correct")
  end

  it "wont allow someone to logi n they have the wrong email" do
    User.create!(name: "John", email: "John@johnny.com", password: "bro", password_confirmation: "bro", authorization_token: SecureRandom.hex(10))
    post :create, params: {user: {email: "J@johnny.com", password: "bro"}}
    body = JSON.parse(response.body)
    expect(body["message"]).to eq("Email or Password in not correct")
  end

  it "wont allow someone to log in if they have the wrong password" do
    User.create!(name: "John", email: "John@johnny.com", password: "bro", password_confirmation: "bro", authorization_token: SecureRandom.hex(10))
    post :create, params: {user: {email: "John@johnny.com", password: "dude"}}
    body = JSON.parse(response.body)
    expect(body["message"]).to eq("Email or Password in not correct")
  end

  it "wont allow someone to logout if they have not logged in first" do
    delete :destroy
    body = JSON.parse(response.body)
    expect(body["message"]).to eq("Please log in")
  end

  it "will allow someone to logout if they have logged in" do
    john = User.create!(name: "John", email: "John@johnny.com", password: "bro", password_confirmation: "bro", authorization_token: SecureRandom.hex(10))
    post :create, params: { user: {email: john.email, password: "bro"} }
    assert response.ok?
    request.headers["HTTP_AUTHORIZATION"] = john.authorization_token
    delete :destroy
    body = JSON.parse(response.body)
    expect(body["message"]).to eq("You are now logged out")
  end

  it "wont allow someone to to log out with the wrong auth token" do
    john = User.create!(name: "John", email: "John@johnny.com", password: "bro", password_confirmation: "bro", authorization_token: SecureRandom.hex(10))
    post :create, params: { user: {email: john.email, password: "bro"} }
    assert response.ok?
    request.headers["HTTP_AUTHORIZATION"] = "hello"
    delete :destroy
    body = JSON.parse(response.body)
    expect(body["message"]).to eq("Please log in")  end
end
