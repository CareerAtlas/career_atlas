class Job < ApplicationRecord
  has_many :saved_jobs
  validates :job_key, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :company, presence: true
  validates :job_title, presence: true
  validates :location, presence: true

  def update_job_and_save(job_key)
    job_from_indeed = IndeedApi.search_for_job(job_key)
    job_update = info_to_update_job(job_from_indeed["results"][0])
    self.update(job_update)
    self.save
  end

  def info_to_update_job(job)
    {
      job_key: job["jobkey"],
      longitude: job["longitude"],
      latitude: job["latitude"],
      company: job["company"],
      job_title: job["jobtitle"],
      location: job["formattedLocationFull"]
    }
  end
end
