class Sleep < ApplicationRecord
  validates :sleep_start, presence: true

  belongs_to :user
end
