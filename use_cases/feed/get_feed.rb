# frozen_string_literal: true

require 'rss'

module Feed
  # GetFeedError class
  class GetFeedError < StandardError; end

  # GetFeed class
  class GetFeed < Feed::Base
    attr_accessor :feed

    def initialize(feed_name:)
      @feed_name = feed_name
    end

    def perform
      response = feed_class.new.call
      @feed = RSS::Parser.parse(response.body)
    end

    private

    attr_reader :feed_name

    def feed_class
      case @feed_name.to_s
      when 'acidcow'
        Services::Acidcow
      else
        raise GetFeedError
      end
    end
  end
end
