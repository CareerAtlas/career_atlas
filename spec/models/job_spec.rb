require 'rails_helper'

RSpec.describe Job, type: :model do

  it "exists" do
    assert Job
  end

  it "can be created" do
    developer_job = Job.create!(job_title: "Software Developer", job_key: "66d032cd079cc5ab", latitude: 38.956764, longitude: -77.361435, location: "Reston, VA", company: "VeriSign")
    expect(developer_job).to be_instance_of(Job)
  end
end
