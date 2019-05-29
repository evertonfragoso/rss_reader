# frozen_string_literal: true

module Services
  # Base Class
  class Base
    include HTTParty

    MAX_RETRY = 3

    attr_accessor :response, :code, :body

    def call
      tries ||= MAX_RETRY
      begin
        setup_headers
        @response = call_operation
        assign_response_info
      rescue Net::OpenTimeout
        raise if (tries -= 1).zero?

        retry
      end
      self
    end

    private

    def setup_headers
      self.class.headers 'Content-Type' => 'text/html; charset=utf-8'
    end

    def success_status_codes
      [200]
    end

    def success?
      success_status_codes.include?(code)
    end

    def assign_response_info
      @code = response.code
      @body = response.body
    end
  end
end
