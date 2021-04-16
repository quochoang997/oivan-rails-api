require 'pagination'

class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  include TokenAuthenticatable
end
