module TokenAuthenticatable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request
    attr_reader :current_user
  end

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    raise(UnauthorizedException) unless @current_user
  end

  def authorize
    raise(UnpermittedException) if current_user.role != 'TEACHER'
    true
  end

  def is_teacher
    current_user.role == 'TEACHER'
  end
end

