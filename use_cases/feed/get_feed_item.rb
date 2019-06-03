# frozen_string_literal: true

module Feed
  # GetFeedError class
  class GetFeedItemError < StandardError; end

  # GetFeed class
  class GetFeedItem < Feed::Base
    attr_accessor :feed_item

    def initialize(feed_name:, url:)
      @uri = parse_url(url)
      @feed = feed_name
    end

    def perform
      request_content
      get_content
      strip_junk_tags!
    end

    private

    attr_reader :feed, :uri, :response

    def decode_url(encoded_url)
      Base64.decode64(CGI.unescape(encoded_url))
    end

    def parse_url(url)
      URI.parse(decode_url(url))
    end

    def request_content
      @response = Services::FeedItem.new(uri).call
    end

    def get_content
			# TODO: implement own video player T-T
      # @feed_item = video? ? video_tag : feed_html_content(response.body)
      @feed_item = feed_html_content(response.body)
    end

    def video_tag
      tag = Nokogiri::HTML::Builder.new do |doc|
        image = /image:\s*?\"(.*?)\"/.match(response.body)
        doc.a(href: video[1], target: '_blank') { doc.img(src: image[1]) }
      end
      tag.to_html
    end

    def video?
      /<!--dle_video_begin:(.*?)-->/.match(@content)
    end

    def feed_html_content(html)
      content = Nokogiri::HTML(html)
      # TODO: make this an adaptor for feed providers
      content = content.at_css('.newsarea') if acidcow?
      content.to_html
    end

    def acidcow?
      feed.to_s == 'acidcow'
    end

    def strip_junk_tags!
      # rubocop:disable Metrics/LineLength
      div_regx = %r{<[div|span]+\s?[^>]*?\s+class=["|']+(?:tools|socnetwork|fb\-like|sorting|advpost)+["|']+\s?[^>]*?>.*?<\/[div|span]+>}mi
      # rubocop:enable Metrics/LineLength
      @feed_item.gsub!(%r{<iframe.*?<\/iframe>}mi, '')
      @feed_item.gsub!(%r{<script.*?<\/script>}mi, '')
      @feed_item.gsub!(div_regx, '')
      @feed_item.gsub!(/<!--.*?-->/m, '')
      @feed_item.gsub!(/<!--/, '')
      @feed_item.gsub!(/-->/, '')
    end
  end
end
