# frozen_string_literal: true

module ApplicationHelpers
  def current?(path='/')
    request.path_info == path ? 'current' : nil
  end

  def strip_tags(content)
    Nokogiri::HTML(content.to_s).text
  end
end
