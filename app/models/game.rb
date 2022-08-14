class Game < ApplicationRecord
    has_many :reviews, dependent: :destroy
    has_one_attached :image
    def avg_score
      unless self.reviews.empty?
        reviews.average(:score).round(1).to_f
      else
        0.0
      end
    end

  def review_score_percentage
    unless self.reviews.empty?
      reviews.average(:score).round(1).to_f*100/5
    else
      0.0
    end
  end
  

    def get_image(width,height)
      unless image.attached?
        file_path = Rails.root.join('app/assets/images/no_image.jpg')
        image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
      image.variant(resize_to_limit: [width,height]).processed
    end
end
