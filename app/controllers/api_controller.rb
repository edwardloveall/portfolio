class ApiController < ApplicationController
  VENDOR_JSON_FORMAT = 'application/vnd.edwardloveall.com+json'.freeze

  protect_from_forgery with: :null_session, if: :json_request?

  def json_request?
    request.format.json? || request.format == VENDOR_JSON_FORMAT
  end

  def authenticate
    authenticate_token || render_unauthorized('Access denied')
  end

  def render_unauthorized(message)
    errors = { errors: message }
    render json: errors, status: :unauthorized
  end

  private

  def authenticate_token
    authenticate_with_http_token do |token, _options|
      ActiveSupport::SecurityUtils.secure_compare(
        ::Digest::SHA256.hexdigest(token),
        ::Digest::SHA256.hexdigest(ENV['MICROBLOG_API_KEY'])
      )
    end
  end
end
