class Image < ApplicationRecord
  validates :name, presence: true
  validates :url, presence: true, format: { with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/i, message: "please enter a valid HTTP url path"}
end
