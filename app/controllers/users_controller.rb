class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id), notice: "保存しました"
    else
      render :new
    end
  end

  def show
  end

  def edit
    if current_user.id != @user.id
      redirect_to posts_path
    else
      render :edit
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: '保存しました'
    else
      render :edit
    end
  end

  private

  #paramsメソッドで表示するUserのID取得
  def set_user
    @user = User.find(params[:id])
  end

  #strong parameters,送られてきているパラメーターの値の正当性をホワイトリストにてチェック
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
end
