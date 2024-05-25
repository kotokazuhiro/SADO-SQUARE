class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "登録情報編集に成功しました"
      redirect_to users_user_path(@user)
    else
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
      redirect_to admin_users_path, notice: 'ユーザーを削除しました。'
  end

 
  private
  
  def user_params
    params.require(:user).permit(:name, :name_kana, :nickname, :telephone_number, :prefectures, :age, :email, :password, :password_confirmation)
  end
  
end
