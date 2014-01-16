class Api::PicturesController < ApplicationController

  skip_before_action :verify_authenticity_token

  respond_to :json

  def upload
    # puts "**************************"
    # puts session[:session_id]
    # puts session[:csrf_id]
    # puts session[:_csrf_token]

  	render :status => 200,
  	       :json => {
  	         :success => true,
  	         :info => "hoge"
  	       }
  end


end