class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user_from_token!, if:     :api_controller?
  before_action :authenticate_user!,            unless: :api_controller?

  private

  def api_controller?
  	request.path_info.match(/^\/api\//)
  end

  def authenticate_user_from_token!
  	user_token = params[:auth_token].presence
  	user       = user_token && User.where(authentication_token: user_token.to_s).first
  	if user
  	  sign_in user, store: false
  	end
  end
end
