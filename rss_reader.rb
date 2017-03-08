require 'sinatra/base'
require 'open-uri'
require 'base64'

class RSSReader < Sinatra::Base

  set :haml, format: :html5, provides: :html5
  set :public_folder, File.dirname(__FILE__) + '/public'

  get '/' do
    require 'rss'

    @feeds = []
    [
      'http://feeds.feedburner.com/acidcow_com?format=xml'
    ].each do |url|
      open(url) { |rss| @feeds << RSS::Parser.parse(rss) }
    end

    haml :index
  end

  get '/url/:url' do
    uri   = Base64.decode64(CGI.unescape(params[:url]))
    html  = Nokogiri::HTML(open(uri))

    items = html.at_css('.newsarea') if /acidcow/.match(uri)

    return erb 'No items!', layout: false if items.nil?

    content = items.to_html

    video   = /<!--dle_video_begin:(.*?)-->/.match(content)
    return erb Nokogiri::HTML::Builder.new { |doc|
      image = /image:\s*?\"(.*?)\"/.match(content)
      doc.a(href: video[1], target: '_blank') { doc.img(src: image[1]) }
    }.to_html, layout: false if video

    content = content.gsub(/<iframe.*?<\/iframe>/m, '')
    content = content.gsub(/<script.*?<\/script>/m, '')
    content = content.gsub(/<[div|span]+\s?[^>]*?\s+class=[\"|']+[tools|socnetwork|fb\-like|sorting|advpost]+[\"|']+\s?[^>]*?>.*?<\/[div|span]+>/m, '')
    content = content.gsub(/<!--.*?-->/m, '')
    content = content.gsub(/<!--/, '')
    content = content.gsub(/-->/, '')

    erb content, layout: false
  end

  run! if app_file == $0
end

