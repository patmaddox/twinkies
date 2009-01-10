module Twinkies
  class FriendSearcher
    def initialize(username, password)
      @username = username
      @password = password
    end

    def search(term)
      (find_tweets(term) {
        Twitter::Base.new(@username, @password).timeline
      } +
      find_tweets(term) {
        Twitter::Search.new.referencing(@username).containing(term)
      }).sort_by {|t| t.created_at }
    end

    private
    def find_tweets(term, &from)
      begin
        from.call.select { |tweet| tweet.text.include?('http') }
      rescue Twitter::CantConnect => e
        # twitter's down, who'da thunk?!
        $stderr.puts e
        []
      end
    end
  end
end
