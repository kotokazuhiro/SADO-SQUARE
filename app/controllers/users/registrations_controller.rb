class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, only: [:create]
  
  def after_sign_up_path_for(resource)
    users_homes_about_path
  end
  
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :name_kana, :nickname, :prefectures, :age, :telephone_number])
  end
  
end
