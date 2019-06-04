class UserController < ApplicationController
  before_action :auth_user, only: [:show, :update]

  def create
    params.require(:user).permit(:nickname, :password)
    nickname, password = params.values_at :nickname, :password

    if(User.exists?(nickname: nickname))
      head 405
      return
    end

    user = User.new({
      nickname: nickname,
      password: password
    })

    data = {nickname: nickname}.to_json

    sub = $redis.publish 'newUser', data
    
    if sub<=0
      head 405
      return
    end

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
      @token = JsonWebToken.encode({user_id: user[:id]})
      render "new.json", status: 200
    else
      head 405
    end
  end

  def show
    id = get_id_from_token
    @user = User.where(id: id).first

    render "show.json", status: 200
  end

  def update
    params.require(:user).permit(:nickname, :description)
    nickname, description = params.values_at :nickname, :description
    User.where(id: get_id_from_token).update_all(nickname: nickname, description: description)

    head 204
  end
end
