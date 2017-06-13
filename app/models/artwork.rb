class Artwork < ApplicationRecord
  has_many :appointments, dependent: :destroy
  has_many :renters, through: :appointments, source: :user
  belongs_to :owner , class_name: 'User', foreign_key: 'user_id'
end
