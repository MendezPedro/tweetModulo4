class ApplicationController < ActionController::Base
    before_action :banned?
    before_action :devise_params, if: :devise_controller?
    skip_before_action :verify_authenticity_token
    protected 

    def banned?
        if current_user.present? && current_user.banned?
            sign_out current_user
            flash[:error] = 'Haz banneado a este usuario'
            root_path
        end
    end
    def devise_params
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :photo])
        devise_parameter_sanitizer.permit(:update, keys: [:name, :photo, :banned])
        
    end
    
end
