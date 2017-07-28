module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do

    rescue_from ActiveRecord::RecordInvalid, with: :four_two_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_two_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_two_two

    rescue_from ActiveRecord::RecordNotFound do |exception|
      json_response({ message: exception.message }, :not_found)
    end

    private

    def four_two_two exception
      json_response({ message: exception.message }, :unprocessable_entity)
    end

    def unauthorized_request exception
      json_response({ message: exception.message }, :unauthorized)
    end
  end
end
