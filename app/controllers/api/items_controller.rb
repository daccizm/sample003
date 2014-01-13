class Api::ItemsController < ApplicationController
  respond_to :json

  def all
  	render :status => 200,
  	       :json => {
  	         :success => true,
  	         :info => "hoge"
  	       }
  end


end