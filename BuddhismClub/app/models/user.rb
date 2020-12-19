class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  after_commit :add_default_avatar, on: [:create, :update]
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :home, dependent: :destroy
  has_many :friendships
  has_many :friends, :through => :friendships


  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: "37x37!").processed
    else
      add_default_avatar
      avatar_thumbnail
    end
  end

  private

  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join(
            'app', 'assets', 'images', 'default_profile.jpg'
          )
        ), filename: 'default_profile.jpg',
        content_type: 'image/jpg'
      )
    end
  end

end
