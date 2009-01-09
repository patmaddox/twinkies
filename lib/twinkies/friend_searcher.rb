module Twinkies
  class FriendSearcher
    def initialize(username, password)
      @username = username
      @password = password
    end

    def search(term)
      Twitter::Base.new(@username, @password).timeline.select do |tweet|
        tweet.text.include?('http')
      end
    end
  end
end
