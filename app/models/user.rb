class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :schedules
  has_many :shifts
  has_many :sites
  has_many :requests

  validates :name, presence: true
  validates :hours, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :manager, inclusion: { in: [true, false] }
end
