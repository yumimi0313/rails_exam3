class PostsController < ApplicationController
  before_action :set_post, only:[:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    #postsはuserモデルで定義したアソシエーション、buildはアソシエーションのNewバージョン
    @post = current_user.posts.build(post_params)
    if params[:back]
      render :new
    else
      if @post.save
      PostMailer.post_mail(@post).deliver
      redirect_to posts_path, notice: "保存しました"
      else
      render :new
      end
    end
  end
  
  def confirm
    @post = Post.new(post_params)
    @post = current_user.posts.build(post_params)
    render :new if @post.invalid? 
  end

  def show
    @favorite = current_user.favorites.find_by(post_id: @post.id)
  end

  def edit
    if current_user.id != @post.user_id
      redirect_to posts_path
    else
      render :edit
    end
  end

  def update
   if @post.update(post_params)
      redirect_to posts_path, notice: "保存しました"
    else
      render :edit
   end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "保存しました"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :image, :image_cache)
  end
end
