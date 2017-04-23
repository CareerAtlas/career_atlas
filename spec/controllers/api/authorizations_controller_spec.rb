require 'rails_helper'

RSpec.describe Api::AuthorizationsController, type: :controller do

  it "allows someone to log in" do
    moose = User.create!(name: "Moose", email: "Moose@gooddogs.com", password: "treats", password_confirmation: "treats")
    post :create, params: { email: moose.email, password: "treats" }
    assert response.ok?
  end

end
