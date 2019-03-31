class UserController < ApplicationController
  def create
    params.require(:user).permit(:nickname, :password)

    if !User.exists?(params[:nickname])
      user = User.new({
        nickname: params[:nickname],
        password: params[:password]
      })

      if user.save
        render json: {message: 'created'}, status: 201
        return
      end           
    end

    render json: {message: 'error'}, status: 405
  end
end
