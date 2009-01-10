require 'sinatra'

module Twinkies
  class Server
    def initialize(config)
      @tweet_db = config.tweet_db
      @username = config.username
      @password = config.password
    end

    def run
      setup_db
      start_tweet_refresher
      handle_request
    end

    def setup_db
      DataMapper.setup(:default, "sqlite3://#{@tweet_db}")
      DataMapper.auto_upgrade!
    end

    def start_tweet_refresher
      Thread.abort_on_exception = true
      Thread.new do
        loop do
          puts "refreshing tweets..."
          Item.refresh @username, @password
          sleep 60
        end
      end
    end

    def handle_request
      username = @username # builder must instance_eval?

      get '/feed.xml' do
        pieces = ['http://', request.env['SERVER_NAME']]
        pieces << ":#{request.env['SERVER_PORT']}" unless request.env['SERVER_PORT'].to_i == 80
        pieces << request.env['REQUEST_PATH']
        request_path = pieces.join

        builder do |xml|
          xml.instruct!
          xml.rss :version => '2.0', "xmlns:atom" => "http://www.w3.org/2005/Atom" do
            xml.channel do
              xml.title "#{username}'s twitter URL feed"
              xml.description "#{username}'s twitter URL feed"
              xml.link "http://twitter.com/#{username}"
              xml.tag! "atom:link", :rel => "self", :href => request_path

              Item.latest.each do |tweet|
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
  end
end
