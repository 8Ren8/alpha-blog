class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in?
    
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
        #!! turn current_user instance variable into boolean
        !!current_user
    end

    def require_user
        if !logged_in?
            flash[:alert] = "You must log in first before you can do that"
            redirect_to login_path
        end
    end
end
