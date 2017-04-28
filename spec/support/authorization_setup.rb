module AuthorizationSetup

  def create_john
    User.create!(
      name: "John",
      email: "John@johnny.com",
      password: "bro",
      password_confirmation: "bro",
      authorization_token: SecureRandom.hex(10)
      )
  end

  def create_job
    Job.create!(
      job_key: "24c5d6db45db2b16",
      longitude: -77.07143,
      latitude: 38.96978,
      company: "Precision System Design, Inc.",
      job_title: "Apps Developer (Android/Java)",
      location: "Chevy Chase, MD"
      )
  end

end
