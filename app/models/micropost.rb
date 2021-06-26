class Micropost < ApplicationRecord
  belongs_to :user

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size

  delegate :name, to: :user, prefix: true

  scope :feed, lambda { |user_id|
    user = User.find(user_id)
    where(user_id: [user.id, user.following_ids].flatten).order(created_at: :desc)
  }

  private

  # アップロードされた画像のサイズをバリデーションする
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, 'should be less than 5MB')
    end
  end
end
