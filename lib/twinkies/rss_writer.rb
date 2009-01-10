module Twinkies
  class RssWriter
    def initialize(username, request_path, items)
      @username = username
      @request_path = request_path
      @items = items
    end

    def rss
      username = @username
      request_path = @request_path
      items = @items

      xml = Builder::XmlMarkup.new :indent => 2
      xml.instruct!
      xml.rss :version => '2.0', "xmlns:atom" => "http://www.w3.org/2005/Atom" do
        xml.channel do
          xml.title "#{username}'s twitter URL feed"
          xml.description "#{username}'s twitter URL feed"
          xml.link "http://twitter.com/#{username}"
          xml.tag! "atom:link", :rel => "self", :href => request_path

          @items.each do |tweet|
            xml.item do
              xml.title "#{tweet.user} - #{tweet.text}"
              xml.link tweet.link
              xml.pubDate tweet.created_at.rfc822
              xml.guid tweet.guid, :isPermaLink => false
            end
          end
        end
      end
    end
  end
end
