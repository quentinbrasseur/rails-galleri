class Artwork < ApplicationRecord
  has_attachment :photo #download artwork image and stock it on cloudinary
  has_many :appointments, dependent: :destroy
  has_many :renters, through: :appointments, source: :user
  belongs_to :owner , class_name: 'User', foreign_key: 'user_id'
end
