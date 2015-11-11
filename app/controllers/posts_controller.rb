class PostsController < PrivateApiController
  def index
    posts = Post.all
    render json: posts
  end

  def create
    post = Post.create(post_params)
    render_resource_or_errors(post)
  end

  def show
    post = Post.find(params[:id])
    render json: post
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :video)
  end
end
