require 'rails_helper'

RSpec.describe Api::AuthorizationController, type: :controller do

  it "allows someone to log in" do
    User.create!(name: "John", email: "John@johnny.com", password: "bro", password_confirmation: "bro", authorization_token: SecureRandom.hex(10))
    john = User.find_by(email: "John@johnny.com")
    post :create, params: { email: john.email, password: "bro" }
    assert response.ok?
  end
end
