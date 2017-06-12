class User < ApplicationRecord
  has_many :artworks, through: :appointments
  has_many :appointments
end
