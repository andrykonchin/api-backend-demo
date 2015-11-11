class VideosController < PrivateApiController
  def show
    post = Post.find(params[:post_id])
    video = post.video
    send_file(video.path,
      filename:    video.original_filename,
      type:        video.content_type,
      disposition: 'inline'
    )
  end
end
