task redis_subscribe: :environment do
  Redis::Client::DEFAULTS[:host] = ENV['REDIS_HOST']
  redis = Redis.new(host: ENV['REDIS_HOST'], port: ENV['REDIS_PORT'])
  
  redis.subscribe "newConversation" do |on|
    on.message do |channel, data|
      Goal.where(id: data.goal_id).first.update(conversation_id: data.conversation_id)
    end
  end    
end