class Post < ApplicationRecord
  validates :content, presence: true
  validates :image, presence: true
  validates :user_id, presence: true
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user 
  mount_uploader :image, ImageUploader
end
