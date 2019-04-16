class ConversationController < ApplicationController
  before_action :auth_user

  def index
    offset, limit = params.values_at :offset, :limit
    nickname = User.where(id: get_id_from_token).first.nickname
    @conversations = $userDoc.find(nickname: nickname).skip(offset.to_i).limit(limit.to_i).first['conversations'].map do |c|
      $conversationDoc.find(_id: BSON::ObjectId(c)).first['participants']
    end

    render "index.json", status: 200
  end

  def show
    
  end

  def new
    
  end

  def message
    
  end
end
