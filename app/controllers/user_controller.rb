class UserController < ApplicationController
  before_action :auth_user, only: [:show, :update]

  def create
    params.require(:user).permit(:nickname, :password)
    nickname, password = params.values_at :nickname, :password

    user = User.new({
      nickname: nickname,
      password: password
    })

    if user.save
      head 201
    else
      head 405
    end
  end

  def new
    params.require(:user).permit(:nickname, :password)
    nickname, password = params.values_at(:nickname, :password)
    user = User.find_by(nickname: nickname)

    if user && !!user.authenticate(password)
      @jwt = JsonWebToken.encode({user_id: user[:id]})
      render "new.json", status: 200
    else
      head 405
    end
  end

  def show
    nickname = get_nickname_from_token
    @user = User.where(nickname: nickname).first

    render "show.json", status: 200
  end

  def update
    params.require(:user).permit(:nickname, :description)
    nickname, description = params.values_at :nickname, :description
    User.where(nickname: get_nickname_from_token).update_all(nickname: nickname, description: description)

    head 204
  end
end
