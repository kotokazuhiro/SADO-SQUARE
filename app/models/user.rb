class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :nices, dependent: :destroy
  
  
  validates :name, presence: { message: "名前を入力してください" }
  validates :name_kana, presence: { message: "フリガナを入力してください" }
  validates :nickname, presence: { message: "ニックネームを入力してください" }
  validates :telephone_number, presence: { message: "電話番号を入力してください" }
  validates :prefectures, presence: { message: "お住まいの都道府県を入力してください" }
  validates :age, presence: { message: "年齢を入力してください" }
  # validates :email, presence: { message: "メールアドレスを入力してください" }
  # validates :password, presence: { message: "パスワードを入力してください" }
  # validates :password_confirmation, presence: { message: "パスワード(確認用)を入力してください" }
  
  
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
      user.name_kana = "ゲストユーザー"
      user.nickname = "ゲスト"
      user.telephone_number = "09012345678"
      user.prefectures = "新潟県"
      user.age = "20"
      user.password_confirmation = user.password
    end
  end
  
  def guest_user?
    email == GUEST_USER_EMAIL
  end

  
end
