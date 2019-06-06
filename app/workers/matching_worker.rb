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

      first.update(partner_id: second.user_id, partner_name: User.where(id: second.user_id).first.nickname)
      second.update(partner_id: first.user_id, partner_name: User.where(id: first.user_id).first.nickname)

      conversation = [
        {nickname: User.where(id: first.user_id).first.nickname, title: first.title, id: first.id},
        {nickname: User.where(id: second.user_id).first.nickname, title: second.title, id: second.id}
      ].to_json

      $redis.publish('newConversation', conversation)
    end
  end
end
