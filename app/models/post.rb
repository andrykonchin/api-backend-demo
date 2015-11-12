class Post < ActiveRecord::Base
  has_attached_file :video

  validates :title, :body, presence: true
  validates_attachment :video, content_type: { content_type: 'video/quicktime' }
end
