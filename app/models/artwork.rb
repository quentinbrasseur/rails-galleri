class Artwork < ApplicationRecord
  has_many :appointments, dependent: :destroy
end
