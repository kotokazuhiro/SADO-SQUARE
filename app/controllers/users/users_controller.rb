class Users::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
  
  def nices
    @user = User.find(params[:id])
    nices= Nice.where(user_id: @user.id).pluck(:post_id)
    @nice_posts = Post.find(nices)
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
  
  def unsubscribe
    @user = User.find(params[:id])
  end

  def withdrawal
    @user = User.find(params[:id])
    @user.update(withdrawal_flag: true)
    reset_session
    flash[:notice] = "退会が完了致しました"
    redirect_to root_path
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :name_kana, :nickname, :telephone_number, :prefectures, :age, :email, :password, :password_confirmation)
  end
  
  def is_matching_login_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to users_posts_path(@user)
    end
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end  
  
end
