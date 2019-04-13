require 'json'

class MatchingJob < ApplicationJob
  queue_as :default

  def perform(*args)

  end
end
