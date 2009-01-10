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
      Sinatra::Base.run!
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
      username = @username # instance_eval..
      Sinatra::Base.get '/feed.xml' do
        pieces = ['http://', request.env['SERVER_NAME']]
        pieces << ":#{request.env['SERVER_PORT']}" unless request.env['SERVER_PORT'].to_i == 80
        pieces << request.env['REQUEST_PATH']
        request_path = pieces.join
        RssWriter.new(username, request_path, Item.latest).rss
      end
    end
  end
end
