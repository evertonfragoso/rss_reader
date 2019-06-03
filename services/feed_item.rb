# frozen_string_literal: true

module Services
  # Acidcow Service class
  class FeedItem < Services::Base
    def initialize(url)
      super()
      @url = url
    end

    def call_operation
      self.class.get(url)
    end

    private

    attr_reader :url
  end
end
