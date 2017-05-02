class Job < ApplicationRecord
  has_many :saved_jobs
  validates :job_key, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :company, presence: true
  validates :job_title, presence: true
  validates :location, presence: true
  validates :url, presence: true


  def update_job(job_info)
    update(job_info.except(:date_posted))
  end

  def self.create_or_update_job_by_key(job_key)
    job = Job.find_or_initialize_by(job_key: job_key)
    job.update_job_and_save(job.job_key)
    job
  end

  def indeed_data
    IndeedApi.find_job(self.job_key).except(:date_posted)
  end

  def update_job_and_save(job_key)
    update(indeed_data)
  end
end
