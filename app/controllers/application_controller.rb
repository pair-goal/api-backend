class ApplicationController < ActionController::API
  def auth_user
    token = request.headers["Access-Token"]
    print "------------------"
    print token
    decoded_token = JsonWebToken.decode(token)
    
    if decoded_token==false
      head 403
    end
  end
end
