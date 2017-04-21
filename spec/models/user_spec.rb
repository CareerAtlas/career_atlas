require 'rails_helper'

RSpec.describe User, type: :model do
  it "exists" do
    assert User
  end

  it "can be created" do
    params = { name: "Moose", email: "moose@gmail.com", password: "treat", password_confirmation: "treat" }
    more_params = { name: "Robby", email: "robby@gmail.com", password: "dude", password_confirmation: "dude" }

    moose = User.create(params)
    expect(moose).to be_instance_of(User)
    expect{ User.create!(more_params) }.to change { User.count }.by(1)
  end
end
