class Users::SessionsController < Devise::SessionsController
    def new
      self.resource = Utilizer.new
      super
    end
  
    def create
      # Find the user by email
      self.resource = Utilizer.find_for_database_authentication(email: params[:utilizer][:email])
  
      if resource && resource.valid_password?(params[:utilizer][:password])
        sign_in(resource_name, resource)
        redirect_to after_sign_in_path_for(resource)
      else
        flash.now[:alert] = "Invalid email or password."
        self.resource = Utilizer.new  # Re-initialize resource to show errors
        render :new
      end
    end
  end