class GuestController < ApplicationController

  skip_before_action :authenticate_user!

  def index
  	resource = User.find_for_database_authentication( account: 'guest' )
  	sign_in( 'user', resource )
  end

end
