require 'redis'

Redis::Client::DEFAULTS[:host] = ENV['REDIS_HOST']
$redis = Redis.new(host: ENV['REDIS_HOST'], port: ENV['REDIS_PORT'])