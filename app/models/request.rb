class Request < ApplicationRecord
  # after_create_commit { broadcast_append_to "requests" }
  # after_update_commit { broadcast_replace_to "requests" }
  belongs_to :user
  belongs_to :shift
  belongs_to :schedule

  validates :request_type, :request_status, presence: true
  validates :comment, length: { maximum: 500 }
end
