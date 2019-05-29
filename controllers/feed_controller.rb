# frozen_string_literal: true

# Feeds Controller
class FeedController < ApplicationController
  get '/' do
    haml :index, locals: { feeds: [:acidcow] }
  end

  get '/:feed' do
    get_feed = Feed::GetFeed.perform(feed_name: params[:feed])
    haml :feed, locals: { feed: get_feed.feed }
  end

  get '/:feed/:url' do
    url   = Base64.decode64(CGI.unescape(params[:url]))
    uri   = URI.parse(url)
    html  = Nokogiri::HTML(uri.read)

    items = html.at_css('.newsarea') if url =~ /acidcow/

    return erb 'No items!', layout: false if items.nil?

    content = parse_content(items.to_html)

    erb content, layout: !request.xhr?
  end
end
