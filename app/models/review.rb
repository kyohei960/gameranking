class Review < ApplicationRecord
  belongs_to :user
  belongs_to :game
  validates :score, presence: true
  validates :content, presence: true
end
