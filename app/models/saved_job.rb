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

  def self.check_for_current_user(jobs_from_indeed, user)
    if user
      has_current_user_saved_these_jobs(jobs_from_indeed, user)
    else
      no_saved_jobs(jobs_from_indeed)
    end
  end

  def self.has_current_user_saved_these_jobs(jobs_from_indeed, user)
    user_jobs_keys = user.jobs.pluck(:job_key)
    jobs_from_indeed.each do |job|
      if user_jobs_keys.include?(job[:job_key])
        job[:saved] = true
      else
        job[:saved] = false
      end
    end

  end

  def self.no_saved_jobs(jobs_from_indeed)
    jobs_from_indeed.each do |job|
      job[:saved] = false
    end
  end

end
