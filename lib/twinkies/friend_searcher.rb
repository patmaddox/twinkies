module Twinkies
  class FriendSearcher
    def initialize(username, password)
      @username = username
      @password = password
    end

    def search(term)
      all_friends.in_groups_of(10,false).inject([]) { |tweets, friends|
        tweets += Twitter::Search.new.containing(term).
                    from(friends.join(' OR ')).fetch.results
      }.sort_by {|t| t.id}
    end

    private
    def all_friends
      Twitter::Base.new(@username, @password).
        friends.map {|f| f.screen_name }
    end
  end
end
