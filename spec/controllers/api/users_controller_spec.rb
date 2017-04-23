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
end
