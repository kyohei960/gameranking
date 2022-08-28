class Tag < ApplicationRecord
  has_many :tagmaps, dependent: :destroy
  has_many :games, through: :tagmaps
end
