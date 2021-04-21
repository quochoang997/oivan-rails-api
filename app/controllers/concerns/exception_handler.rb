module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end

    rescue_from UnauthorizedException do
      json_response({ error: "Unauthorized" }, :unauthorized)
    end

    rescue_from UnpermittedException do
      json_response({ error: "Forbidden" }, :forbidden)
    end

    # rescue_from Exception do
    #   json_response({ error: "Bad request" }, :bad_request)
    # end
  end
end

class UnauthorizedException < StandardError; end
class UnpermittedException < StandardError; end
