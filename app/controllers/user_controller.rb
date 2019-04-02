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
      render json: {message: 'success'}, status: 200
    else
      render json: {message: 'error'}, status: 405
    end
  end
end
