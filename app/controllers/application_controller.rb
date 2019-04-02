class ApplicationController < ActionController::API
  def auth_user
    token = request.headers["Access-Token"]
    decoded_token = JsonWebToken.decode(token)
    
    if decoded_token==false
      render json: {message: 'error'}, status: 403
    end
  end
end
