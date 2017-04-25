require 'rails_helper'

RSpec.describe Api::AuthorizationController, type: :controller do

  it "allows someone to login" do
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

  it "wont allow someone to login they have the wrong email" do
    User.create!(name: "John", email: "John@johnny.com", password: "bro", password_confirmation: "bro", authorization_token: SecureRandom.hex(10))
    post :create, params: {user: {email: "J@johnny.com", password: "bro"}}
    body = JSON.parse(response.body)
    expect(body["message"]).to eq("Email or Password in not correct")
  end

  it "wont allow someont to login if they have the wrong password" do
    User.create!(name: "John", email: "John@johnny.com", password: "bro", password_confirmation: "bro", authorization_token: SecureRandom.hex(10))
    post :create, params: {user: {email: "John@johnny.com", password: "dude"}}
    body = JSON.parse(response.body)
    expect(body["message"]).to eq("Email or Password in not correct")
  end
end
