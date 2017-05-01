require "rails_helper"

RSpec.describe NewUserMailer, type: :mailer do
  let(:john) { create_john }
  let(:mail) {NewUserMailer.sign_up_email(john)}

  it "exists" do
    assert NewUserMailer
  end

  it "renders the subject with a user" do
    expect(mail.subject).to eq("Welcome to CareerAtlas John!")
  end

  it "renders the user's email" do
    expect(mail.to).to eq([john.email])
  end

end
