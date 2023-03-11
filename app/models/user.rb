class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { maximum: 80 }
  validates :nickname, presence: true, length: { maximum: 20 }
  validates :phone_number, presence: true

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :rooms, through: :entries

  # フォロー関係用
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_users, through: :followers, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followeds, source: :follower # 自分をフォローしている人


  def follow(user_id)
    followers.create(followed_id: user_id)
  end

  def unfollow(user_id)
    followers.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    following_users.include?(user)
  end

end
