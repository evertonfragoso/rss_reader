# frozen_string_literal: true

# Feeds Helper
module FeedHelpers
  def parse_content(content)
    @content = content
    return video_tag if video?

    strip_junk_tags!
    @content
  end

  def feed_items(content)
    @content = content
  end

  private

  def video?
    /<!--dle_video_begin:(.*?)-->/.match(@content)
  end

  def video_tag
    tag = Nokogiri::HTML::Builder.new do |doc|
      image = /image:\s*?\"(.*?)\"/.match(@content)
      doc.a(href: video[1], target: '_blank') { doc.img(src: image[1]) }
    end
    tag.to_html
  end

  def strip_junk_tags!
    # rubocop:disable Metrics/LineLength
    div_regx = %r{<[div|span]+\s?[^>]*?\s+class=["|']+(?:tools|socnetwork|fb\-like|sorting|advpost)+["|']+\s?[^>]*?>.*?<\/[div|span]+>}mi
    # rubocop:enable Metrics/LineLength
    @content.gsub!(%r{<iframe.*?<\/iframe>}mi, '')
            .gsub!(%r{<script.*?<\/script>}mi, '')
            .gsub!(div_regx, '')
            .gsub!(/<!--.*?-->/m, '')
            .gsub!(/<!--/, '')
            .gsub!(/-->/, '')
  end
end
