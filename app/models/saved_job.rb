class SavedJob < ApplicationRecord
  belongs_to :job
  belongs_to :user
  validates :user_id, presence: true
  validates :job_id, presence: true
  validates :user_id, uniqueness: { scope: :job_id }

  def self.new_by_job_key(job_key, user)
    job = Job.create_or_update_job_by_key(job_key)
    SavedJob.new(job: job, user: user)
  end
end
