require 'redis'

Redis::Client::DEFAULTS[:host] = ENV['RAILS_HOST']
$redis = Redis.new(host: ENV['RAILS_HOST'], port: ENV['RAILS_PORT'])