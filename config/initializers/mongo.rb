require 'mongo'

$client = Mongo::Client.new(ENV['MONGODB_URI'])