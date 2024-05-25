class Users::SessionsController < Devise::SessionsController
  before_action :reject_user, only: [:create]
  
  
  def after_sign_in_path_for(resource)
    users_user_path(resource.id)
  end
  
  def guest_sign_in
    @user = User.guest
    sign_in @user
    redirect_to users_user_path(@user.id), notice: "ゲストユーザーでログインしました。"
  end
  
  protected
  
  def reject_user
    @user = User.find_by(name: params[:user][:name])
    if @user 
      if @user.valid_password?(params[:user][:password]) && (@user.withdrawal_flag == true)
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to new_user_registration_path
      else
        flash[:notice] = "項目を入力してください"
      end
    end
  end
  
  
  private

  # def user_state
  #   @user = User.find_by(email: params[:user][:email])
  #   return if @user.nil?
  #   return unless @user.valid_password?(params[:user][:password])
  #   if is_deleted == true
  #     redirect_to new_user_registration_path
  #   else
  #     render new_user_session_path
  #   end
  # end
  
end
