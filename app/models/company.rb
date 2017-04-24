class Company < ApplicationRecord
  belongs_to :job
  validates :job_id, presence: true
end
