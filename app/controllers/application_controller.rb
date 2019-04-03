class ApplicationController < ActionController::API
  def auth_user
    token = request.headers["Access-Token"]
    print "------------------"
    print token
    decoded_token = JsonWebToken.decode(token)
    print "-------------------"
    print decoded_token["user_id"]
    if decoded_token==false
      head 403
    end
  end
end
