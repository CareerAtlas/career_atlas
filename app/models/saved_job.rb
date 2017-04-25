class SavedJob < ApplicationRecord
  belongs_to :job
  belongs_to :user
  validates :user_id, presence: true
  validates :job_id, presence: true
end
