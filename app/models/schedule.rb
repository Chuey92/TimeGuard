class Schedule < ApplicationRecord
  belongs_to :user
  belongs_to :site

  has_many :shifts, dependent: :destroy
  has_many :requests
  validates :date, presence: true

  delegate :name, to: :site, prefix: true
end
