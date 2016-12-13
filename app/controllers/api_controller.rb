class ApiController < ApplicationController
  VENDOR_JSON_FORMAT = 'application/vnd.edwardloveall.com+json'.freeze

  protect_from_forgery with: :null_session, if: :json_request?

  def json_request?
    request.format.json? || request.format == VENDOR_JSON_FORMAT
  end
end
