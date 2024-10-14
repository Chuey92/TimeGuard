class Request < ApplicationRecord
  belongs_to :user
  belongs_to :shift
  belongs_to :schedule
end
