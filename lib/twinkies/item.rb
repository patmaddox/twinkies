module Twinkies
  class Item
    include DataMapper::Resource
    property :id, Integer, :serial => true
    property :twitter_id, Integer
    property :encoded_tweet, Text
    property :link, String

    def tweet=(s)
      self.twitter_id = s.id
      @tweet = s
      self.encoded_tweet = Marshal.dump(s)
    end

    def tweet
      @tweet ||= Marshal.load(encoded_tweet)
    end

    def text
      tweet.text
    end

    def save
      @existing = Item.first(:twitter_id => twitter_id)
      if @existing && @existing.link == link
        self.id = @existing.id
        true
      else
        super
      end
    end
  end
end
