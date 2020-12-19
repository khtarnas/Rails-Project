class Comment < ApplicationRecord
  belongs_to :post
  validates :content, presence: true,
   length: {maximum: 280},
   allow_nil: false,
   allow_blank: false
end
