class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :video_updated_at, :created_at, :updated_at

  def video_updated_at
    object.video_updated_at.try(:iso8601)
  end

  def created_at
    object.created_at.try(:iso8601)
  end

  def updated_at
    object.updated_at.try(:iso8601)
  end
end
