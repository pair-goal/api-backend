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
    id, offset, limit = params.values_at :id, :offset, :limit
    @messages = $messageDoc.find(_id: BSON::ObjectId(id)).skip(offset.to_i).limit(limit.to_i)
    
    render "show.json", status: 200
  end

  def new
    id, content = params.values_at :id, :content
    nickname = User.where(id: get_id_from_token).first.nickname
    data = {id: id, content: content, nickname: nickname}.to_json

    sub = $redis.publish 'sendMessage', data
    
    if sub>0
      head 204
    else
      head 405
    end
  end

  def message
    id = params[:id]
    $redis.select 2
    message_content, message_at = $redis.hmget(id, 'content', 'created_at')

    unless message_content and message_at
      message = $messageDoc.find(_id: BSON::ObjectId.from_string(id)).first
      message_content = message['content']
      message_at = message['created_at']
    end

    render status: 200, json: {content: message_content, at: message_at}
  end
end
