require 'rails_helper'

RSpec.describe Job, type: :model do

  it "exists" do
    assert Job
  end

  it "can be created" do
    expect(create_job).to be_instance_of(Job)
  end
end
