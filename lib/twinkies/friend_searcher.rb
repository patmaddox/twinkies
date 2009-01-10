module Twinkies
  class FriendSearcher
    def initialize(username, password)
      @username = username
      @password = password
    end

    def search(term)
      begin
        Twitter::Base.new(@username, @password).timeline.select do |tweet|
          tweet.text.include?('http')
        end
      rescue Twitter::CantConnect => e
        # twitter's down, who'da thunk?!
        $stderr.puts e
        []
      end
    end
  end
end
