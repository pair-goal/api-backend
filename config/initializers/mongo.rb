require 'mongo'

client = Mongo::Client.new(ENV['MONGODB_URI'])
$userDoc = client[:users]
$conversationDoc = client[:conversations]