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

  def self.check_for_current_user(jobs, user)
    if user
      has_current_user_saved_these_jobs(jobs, user)
    else
      no_saved_jobs(jobs)
    end
  end

  def self.has_current_user_saved_these_jobs(jobs, user)
    jobs.each do |job|
      if user.saved_jobs.joins(:job).find_by("jobs.job_key": job[:job_key])
        job[:saved] = true
      else
        job[:saved] = false
      end
    end

  end

  def self.no_saved_jobs(jobs)
    jobs.each do |job|
      job[:saved] = false
    end
  end

end
