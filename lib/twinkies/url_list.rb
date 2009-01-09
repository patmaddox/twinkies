module Twinkies
  class UrlList
    include Enumerable

    def initialize(*strings)
      strings = strings.first if strings.size == 1 && strings.first.is_a?(Array)
      @urls = strings.inject([]) do |urls, string|
        if block_given?
          yield(string).scan(/http:\/\/\S+/) {|s| urls << {:item => string, :url => s}}
          urls
        else
          urls += string.scan(/http:\/\/\S+/)
        end
      end
    end

    def each(&block)
      @urls.each &block
    end

    def inspect
      @urls.inspect
    end

    def to_s
      @urls.to_s
    end

    def ==(other)
      @urls == other
    end
  end
end
