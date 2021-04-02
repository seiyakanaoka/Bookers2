class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }
  attachment:profile_image

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロワーを取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォローする
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人

  # ユーザーをフォローする、後ほどcontrollerで使用します。
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す、後ほどcontrollerで使用します。
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す、後ほどviewで使用します。
  def following?(user)
    following_user.include?(user)
  end

end
