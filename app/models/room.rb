class Room < ApplicationRecord
  has_secure_password
  has_many :messages
  has_many :room_users
  has_many :users, through: :room_users
  validates :name, presence: true
  validates :roomidname, presence: true, uniqueness: true, length: { in: 4..20 }, format: { with: /[ -~]+/ } #半角記号全部
  validates :password, presence: true, length: { in: 6..20 }, format: { with: /[ -~]+/ } #半角記号全部
end
