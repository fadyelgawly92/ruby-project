class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters 
    devise_parameter_sanitizer.permit(:sign_up , keys: [:name, :date_of_birth, :gender, :email, :password, :password_confirmation ,:image] ) 
    devise_parameter_sanitizer.permit(:sign_in , keys: [:email, :password, :password_confirmation] ) 
    devise_parameter_sanitizer.permit(:account_update , keys: [:name, :date_of_birth, :gender, :email, :password, :password_confirmation , :image] ) 
  end  

end
