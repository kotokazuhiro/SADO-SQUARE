class Post < ApplicationRecord
  
  has_one_attached :image
  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :nices, dependent: :destroy
  
  validates :title, presence: { message: "タイトルを入力してください" }
  validates :place, presence: { message: "場所を入力してください" }
  validates :content, presence: { message: "内容を入力してください" }
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  
  def niced_by?(user)
    nices.exists?(user_id: user.id)
  end
  
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("content LIKE?","#{word}")
    elsif search == "forward_match"
      @post = Post.where("content LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("content LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("content LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end
  
  def self.genre_search(word)
    if word == "sightseeing"
      Post.where(genre_id: 1)
    elsif word == "view"
      Post.where(genre_id: 2)
    elsif word == "hotel"
      Post.where(genre_id: 3)
    elsif word == "other"
      Post.where(genre_id: 4)
    end
  end
  
end
