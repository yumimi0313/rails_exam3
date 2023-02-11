class PostsController < ApplicationController
  before_action :set_post, only:[:show, :edit, :update, :destroy]

  def index
    @post = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_params, notice: "保存しました"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
   if @post.update(post_params)
      redirect_to post_params, notice: "保存しました"
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
