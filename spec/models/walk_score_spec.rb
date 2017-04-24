require 'rails_helper'

RSpec.describe WalkScore, type: :model do

  it "exits" do
    assert WalkScore
  end

  it "can be created" do
    john = User.create!(name: "John", email: "John@Smith.com", password: "hello", password_confirmation: "hello")
    developer_job = john.jobs.create!(job_title: "Software Developer")
    score = WalkScore.create!(job_id: developer_job.id, walking_score: 95)
    expect(score).to be_instance_of(WalkScore)
  end

  it "belongs to a job" do
    john = User.create!(name: "John", email: "John@Smith.com", password: "hello", password_confirmation: "hello")
    developer_job = john.jobs.create!(job_title: "Software Developer")
    score = developer_job.create_walk_score!(walking_score: 95)
    expect(score.job_id).to eq(developer_job.id)
    expect(developer_job.walk_score.walking_score).to eq(95)
  end
end
