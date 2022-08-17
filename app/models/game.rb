class Game < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_one_attached :image
  has_many :tagmaps, dependent: :destroy
  has_many :tags, through: :tagmaps
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

  #検索メソッド、タイトルと内容をあいまい検索する
  def self.games_serach(search)
    Game.where(['title LIKE ?', "%#{search}%"])
  end

  def save_games(tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    # Destroy
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name:old_name)
    end

   # Create
    new_tags.each do |new_name|
      game_tag = Tag.find_or_create_by(tag_name:new_name)
      self.tags << game_tag
    end
  end
end
