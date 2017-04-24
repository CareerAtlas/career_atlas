require 'rails_helper'

RSpec.describe Company, type: :model do

  it "exists" do
    assert Company
  end

  it "can be created" do
    john = User.create!(name: "John", email: "John@Smith.com", password: "hello", password_confirmation: "hello")
    job = john.jobs.create!(job_title: "developer")
    schema = { job_id: job.id, name: "Coke", overall_rating: 5 }
    coke = Company.create!(schema)
    expect(coke).to be_instance_of(Company)
  end

  it "belongs to a job" do
    sam = User.create!(name: "Sam", email: "Sam@Hinkle.com", password: "there", password_confirmation: "there")
    developer_job = sam.jobs.create!(job_title: "Software Developer")
    coke = developer_job.create_company!(name: "Home Depot")
    expect(coke.job_id).to eq developer_job.id
    expect(developer_job.company.name).to eq("Home Depot")
  end
end
