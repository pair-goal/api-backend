class MatchingWorker
  include Sidekiq::Worker

  def perform
    Category.constants(false).each { |category| matching category }
  end

  def matching(category)
    len = $redis.llen(category)/2
    len.times {
      first = Goal.where(id: $redis.rpop(category)).first
      second = Goal.where(id: $redis.rpop(category)).first

      first.update(partner_id: second.user_id)
      second.update(partner_id: first.user_id)
    }
  end
end
