class Request < ApplicationRecord
  belongs_to :user
  belongs_to :shift
  belongs_to :schedule

  validates :request_type, :request_status, presence: true
  validates :comment, length: { maximum: 500 }
end
