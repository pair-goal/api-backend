class UserController < ApplicationController
  def create
    params.require(:user).permit(:nickname, :password)
    nickname, password = params.values_at :nickname, :password

    user = User.new({
      nickname: nickname,
      password: password
    })

    if user.save
      render json: {message: 'created'}, status: 201
    else
      render json: {message: 'error'}, status: 405
    end
  end

  def new
    params.require(:user).permit(:nickname, :password)
    nickname, password = params.values_at(:nickname, :password)
    user = User.find_by(nickname: nickname)

    if user && !!user.authenticate(password)
      jwt = JsonWebToken.encode({user_id: user[:id]})
      render json: {message: 'success', token: jwt}, status: 200
    else
      render json: {message: 'error'}, status: 405
    end
  end

  def show
    token = request.headers["Access-Token"]
    nickname = get_nickname_token(token)["user_id"]
    @user = User.find_by(nickname: nickname)

    render "show.json", status: 200
  end

  def get_nickname_token(token)
    decoded_token = JsonWebToken.decode(token)
  end
end
