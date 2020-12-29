class Image < ApplicationRecord
  URL_REGEX = %r{\A(http|https)://[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(/.*)?\z}i.freeze
  acts_as_taggable_on :tags
  validates :tag_list, presence: true
  validates :name, presence: true
  validates :url, presence: true, format: { with: URL_REGEX, message: 'please enter a valid HTTP url path' }
end
