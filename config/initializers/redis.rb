require 'redis'

$redis = Redis.new(host: ENV['RAILS_HOST'], port: ENV['RAILS_PORT'])