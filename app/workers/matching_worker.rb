class MatchingWorker
  include Sidekiq::Worker

  def perform
    Category.constants(false).each { |c| matching Category.const_get c }
  end

  def matching(category)
    $redis.select(3)
    len = $redis.llen(category)/2
    len.times do
      first = Goal.where(id: $redis.rpop(category)).first
      second = Goal.where(id: $redis.rpop(category)).first

      first.update(partner_id: second.user_id)
      second.update(partner_id: first.user_id)

      conversation = [
        {nickname: first.user_id.nickname, title: first.title},
        {nickname: second.user_id.nickname, title: second.title}
      ].to_json

      $redis.publish('newConversation', conversation)
    end
  end
end
