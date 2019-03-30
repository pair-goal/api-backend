class UserController < ApplicationController
  def create
    params.require(:user).permit(:nickname, :password)

    if User.exists?(params[:nickname])
      render json: {message: 'error'}, status: 405
    else
      user = User.new({
        nickname: params[:nickname],
        password: params[:password]
      })

      user.save
      render json: {message: 'created'}, status: 201      
    end
  end
end
