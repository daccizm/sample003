class Api::SessionsController < Devise::SessionsController

  before_action :ensure_params_exist
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user_from_token!

  # CSRF対策は保留
  after_action :set_csrf_header, only: [:create]

  respond_to :json

  def create
  	resource = User.find_for_database_authentication(
  		account: params[:user][:account]
  	)
  	return invalid_login_attempt unless resource

  	invalid_login_attempt unless resource.valid_password?(params[:user][:password])

    resource.signed_in_authentication_token
		sign_in( resource_name, resource )

		return render json: {
			success:    true,
			auth_token: resource.authentication_token,
			account:    resource.account
		}

  end

  def destroy
    resource = User.find_for_database_authentication(
      account: params[:user][:account]
    )

    resource.signed_out_authentication_token!
    sign_out(resource_name)

    return render json: {
      success: true
    }
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
  	render json: {
  		success: false,
  		message: "Error with your login or password"
  	}, status: 401
  end

  # CSRF対策は保留
  def set_csrf_header
  	response.headers['X-CSRF-Token'] = form_authenticity_token
  end

end