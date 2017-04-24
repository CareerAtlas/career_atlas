require 'rails_helper'

RSpec.describe Job, type: :model do

  it "exists" do
    assert Job
  end

  it "can be created" do
    john = User.create!(name: "John", email: "John@Smith.com", password: "hello", password_confirmation: "hello")
    developer_job = Job.create!(user_id: john.id, job_title: "Software Developer")
    expect(developer_job).to be_instance_of(Job)
  end

  it "belongs to a user" do
    john = User.create!(name: "John", email: "John@Smith.com", password: "hello", password_confirmation: "hello")
    developer_job = john.jobs.create!(job_title: "Software Developer")
    expect(developer_job.user_id).to eq(john.id)
    expect(john.jobs.count).to eq(1)
  end

end
