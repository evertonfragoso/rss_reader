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
    get_feed = Feed::GetFeedItem.perform(feed_name: params[:feed],
                                         url: params[:url])
    items = get_feed.feed_item
    return erb 'No items!', layout: false if items.nil?

    erb items, layout: !request.xhr?
  end
end
