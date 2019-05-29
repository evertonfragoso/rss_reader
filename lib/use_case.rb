# frozen_string_literal: true

# Use Cases wraper module
module UseCase
  extend ActiveSupport::Concern
  include ActiveModel::Validations

  # Extensible perform method
  module ClassMethods
    # The perform method of a UseCase should always return itself
    def perform(*args)
      new(*args).tap(&:perform)
    end
  end

  # implement all the steps required to complete this use case
  def perform
    raise NotImplementedError
  end

  # inside of perform, add errors if the use case did not succeed
  def success?
    errors.none?
  end
end
