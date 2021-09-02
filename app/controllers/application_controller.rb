class ApplicationController < ActionController::Base
    include Pundit
    #protect_from_forgery with: :exception
    protect_from_forgery with: :exception
    #before_action :authenticate_user!
    before_action :update_allowed_parameters, if: :devise_controller?
  
    protected
  
    def update_allowed_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation)}
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
      devise_parameter_sanitizer.permit :accept_invitation, keys: [:email]

    end

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    
  private
 
    def user_not_authorized
      respond_to do |format|
        format.html { redirect_to (request.referer || '/') ,alert: 'you are not authorized!' }
      end
    end
end
