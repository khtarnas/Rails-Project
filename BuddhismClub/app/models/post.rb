class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :file
  validate :correct_file_type
  validates :title, presence: true
  #after_commit :add_default_attachment, on: [:create, :update]

  def correct_file_type
    if self.file.any?
      self.file.each do |type|
        unless type.image? || type.audio? || type.video?
          errors.add(:file, 'must be an image, video or audio clip')
        end
      end
    end
  end

  #unused?
  def add_default_attachment
    unless file.attached?
      file.attach(
        io: File.open(
          Rails.root.join(
            'app', 'assets', 'images', 'default_profile.jpg'
          )
        ), filename: 'default_attachment.jpg',
        content_type: 'image/jpg'
      )
    end
  end
end
