class Job < ApplicationRecord
  has_many :saved_jobs
  validates :job_key, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :company, presence: true
  validates :job_title, presence: true
  validates :location, presence: true
end
