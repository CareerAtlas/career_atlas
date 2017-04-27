class Job < ApplicationRecord
  has_many :saved_jobs
  validates :job_key, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :company, presence: true
  validates :job_title, presence: true
  validates :location, presence: true

  def update_job_and_save(job_key)
    update(IndeedApi.find_job(job_key).except(:url, :date_posted))
    self.save
  end

  def update_job(job_info)
    update(job_info.except(:url, :date_posted))
    self.save
  end
end
