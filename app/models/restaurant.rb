class Restaurant < ApplicationRecord
  validates_presence_of :name
  mount_uploader :image, PhotoUploader
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  # 「使用者喜歡很多餐廳」的多對多關聯
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  # 定義是否被收藏過,在 Class 裡，
  # 使用 self 來代表 instance 本身，並使用關聯方法 self.favorited_users
  # 查出該餐廳物件相關的所有 User 紀錄。
  def is_favorited?(user)
    favorited_users.include?(user)
  end

  def is_liked?(user)
    liked_users.include?(user)
  end
end