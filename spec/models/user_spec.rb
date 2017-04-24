require 'rails_helper'

RSpec.describe User, type: :model do
  it "exists" do
    assert User
  end

  it "can be created" do
    params = { name: "Moose", email: "moose@gmail.com", password: "treat", password_confirmation: "treat" }
    more_params = { name: "Robby", email: "robby@gmail.com", password: "dude", password_confirmation: "dude" }
    moose = User.create!(params)
    expect(moose).to be_instance_of(User)
    expect{ User.create!(more_params) }.to change { User.count }.by(1)
  end

  it "will give a secure random string" do
    params = { name: "Robby", email: "robby@gmail.com", password: "dude", password_confirmation: "dude" }
    robby = User.create!(params)
    robby.secure_random
    robby.save
    expect(robby.authorization_token).to be_present
  end
  
  it "creates a job" do
    john = User.create!(name: "John", email: "John@Smith.com", password: "hello", password_confirmation: "hello")
    john.jobs.create(job_title: "Software Engineer")
    expect(john.jobs.length).to eq(1)

  end
end
