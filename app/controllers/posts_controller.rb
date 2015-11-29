class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :publish, :unpublish, :subscribe]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :check_author, only: [:edit, :update, :destroy]

  def index
    @posts = Post.reverse_order(:desc).published.all
  end

  def unpublished
    @posts = Post.reverse_order(:desc).unpublished.all
    render :index
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    end
  end

  def publish
    @post.published = true
    if @post.save
      redirect_to unpublished_posts_path, notice: 'Пост успешно обновлен.'
    else
      render :edit
    end
  end

  def unpublish
    @post.published = false
    if @post.save
      redirect_to unpublished_posts_path, notice: 'Пост успешно обновлен.'
    else
      render :edit
    end
  end

  def subscribe
    @post.subscribers << current_user
    redirect_to @post, notice: 'Вы подписались на этот пост.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :published, category_ids: [])
    end

    def check_author
      unless current_user.author_of?(@post) || current_user.admin?
        flash[:alert] = "У вас нет прав для выполнения этого действия"
        redirect_to :root
      end
    end
end
