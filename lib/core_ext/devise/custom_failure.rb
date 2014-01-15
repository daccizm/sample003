# module CoreExt
#   module Devise
#     class CustomFailure < ::Devise::FailureApp
#       def respond
#   	    if http_auth?
#   	      http_auth
#   	    elsif request.content_type == "application/json"
#   	      self.status = 401
#   	      self.content_type = "application/json"
#   	      self.response_body = {success: false, error: "Unauthorized"}.to_json
#   	    else
#   	      redirect
#   	    end
#   	  end
#   	end
#   end
# end