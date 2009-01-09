module Twinkies
  class Item
    include DataMapper::Resource
    property :id, Integer, :serial => true
    property :twitter_id, Integer
    property :link, String
    property :user, String
    property :created_at, DateTime
    property :text, Text, :lazy => false

    def tweet=(tweet)
      self.twitter_id = tweet.id
      self.text = tweet.text
      self.user = tweet.user.screen_name
      self.created_at = tweet.created_at
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
