task redis_subscribe: :environment do
  Redis::Client::DEFAULTS[:host] = ENV['REDIS_HOST']
  redis = Redis.new(host: ENV['REDIS_HOST'], port: ENV['REDIS_PORT'])
  
  redis.subscribe "newConversations" do |on|
    on.message do |channel, data|
      hashData = eval data
      hashData[:participants].each do |participant|
        Goal.where(id: participant[:goalId]).first.update(conversation_id: hashData[:conversation_id])
      end
    end
  end    
end