class SavedJob < ApplicationRecord
  belongs_to :job
  belongs_to :user
  validates :user_id, presence: true
  validates :job_id, presence: true


  def self.new_by_job_key(job_key, user)
    job = Job.find_by(job_key: job_key)
    unless job
      create_new_job_and_save(job_key, user)
    else
      job.update_job_and_save(job.job_key)
      SavedJob.create(job_id: job.id, user_id: user.id)
    end
  end

  def self.create_new_job_and_save(job_key, user)
    job_data = IndeedApi.find_job(job_key).except(:url, :date_posted)
    @job = Job.new(job_data)
    if @job.save
      SavedJob.new(job_id: @job.id, user_id: user.id)
    end
  end
end
