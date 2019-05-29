# frozen_string_literal: true

module Services
  # Acidcow Service class
  class Acidcow < Services::Base
    def initialize
      super()
    end

    def call_operation
      self.class.get(feed_url)
    end

    private

    def feed_url
      ApplicationConfig::FeedURL::ACIDCOW
    end
  end
end
