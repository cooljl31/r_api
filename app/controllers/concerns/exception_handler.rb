module ExceptionHandler
  extend ActiveSupport::Concern
included do
        prefix "api"
        version "v1", using: :path
        default_format :json
        format :json
        formatter :json, Grape::Formatter::ActiveModelSerializers
    helpers do
      def permitted_params
        @permitted_params ||= declared(params,
            include_missing: false)
      end

      def logger
        Rails.logger
      end
    end

    rescue_from ActiveRecord::RecordNotFound do |exception|
      json_response({ message: exception.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |exception|
      json_response({ message: exception.message }, :unprocessable_entity)
    end
  end
end
