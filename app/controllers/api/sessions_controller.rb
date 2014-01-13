class Api::SessionsController < Devise::SessionsController

  # protect_from_forgery with: :null_session

  before_action :ensure_params_exist, only: [:create]
  skip_before_action :verify_authenticity_token

  after_action :set_csrf_header, only: [:new, :create]

  respond_to :json

  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    render json: {
      success: true,
      required_sign_in: resource.blank?
    }, status: 200
  end

  def create
  	build_resource
  	resource = User.find_for_database_authentication(
  		account: params[:user][:account]
  	)
  	return invalid_login_attempt unless resource

  	if resource.valid_password?(params[:user][:password])
  		sign_in( resource_name, resource )
  		render json: {
  			success: true,
  			auth_token: resource.authentication_token,
  			account: resource.account
  		}
  		return
  	end
  	invalid_login_attempt
  end


  protected

  def ensure_params_exist
  	return unless params[:user].blank?
  	render json: {
  		success: false,
  		message: "missing user parameter"
  	}, status: 422
  end

  def invalid_login_attempt
  	warden.custom_failure!
  	render json: {
  		success: false,
  		message: "Error with your login or password"
  	}, status: 401
  end

  def set_csrf_header
  	response.headers['X-CSRF-Token'] = form_authenticity_token
  end

end