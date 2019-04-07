class ApplicationController < ActionController::API
  def auth_user
    token = request.headers["Access-Token"]
    decoded_token = JsonWebToken.decode(token)
    if decoded_token==false
      head 403
    end
  end

  def get_id_from_token
    token = request.headers["Access-Token"]
    JsonWebToken.decode(token)["user_id"]
  end
end
