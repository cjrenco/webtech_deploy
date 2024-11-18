class Users::RegistrationsController < Devise::RegistrationsController

    before_action :configure_permitted_parameters
    
    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
      devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password])
    end

    private
    
    def sign_up_params
      params.require(:utilizer).permit(:email, :login, :password, :password_confirmation, :name, :last_name, :role)
    end
  
    def account_update_params
      params.require(:utilizer).permit(:email, :login, :password, :password_confirmation, :name, :last_name, :role)
    end
  end