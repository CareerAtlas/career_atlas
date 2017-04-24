class Job < ApplicationRecord
  belongs_to :user
  has_one :company
  has_one :walk_score
end
